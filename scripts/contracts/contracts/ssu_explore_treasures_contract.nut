this.ssu_explore_treasures_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Category = ::Const.Contracts.Categories.Battle
	},
	function create()
	{
		this.contract.create();
		local r = this.Math.rand(1, 100);

		if (r <= 10)
			this.m.DifficultyMult = this.Math.rand(90, 105) * 0.01;
		else if (r <= 75)
			this.m.DifficultyMult = this.Math.rand(115, 135) * 0.01;
		else
			this.m.DifficultyMult = this.Math.rand(145, 165) * 0.01;

		this.m.Type = "contract.explore_treasures";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_explore_treasures_contract.Name;
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.DescriptionTemplates = [
			"An ancient idol, sacred to %s, has been stolen. Its recovery promises untold rewards, including a famed item!",
			"From the depths of an enemy camp comes a quest to retrieve a lost idol, with the promise of a famed item as your reward.",
			"Behold, the call to recover a revered idol from an enemy camp, with a famed item waiting for the hero who succeeds!",
			"The people of %s seek a champion to reclaim their sacred idol, offering a famed item as a reward for its return.",
			"A revered idol, lost to the ages, must be recovered from an enemy camp. The reward: a famed item of great renown.",
			"An ancient idol has been taken from %s, and its recovery will be handsomely rewarded with a famed item."
		];
	}

	function formatDescription()
	{
		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);

		if (r.find("%") != null)
			r = this.format(r, ::Const.UI.getColorized(this.m.Home.getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));

		this.m.Description = r;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		if (this.m.Home == null)
			this.setHome(this.World.State.getCurrentTown());

		local item;
		local idx = this.Math.rand(1, 3);

		if (idx == 1)
		{
			local items = clone this.Const.Items.NamedWeapons;
			item = this.new("scripts/items/" + items[this.Math.rand(0, items.len() - 1)]);
		}
		else if (idx == 2)
			item = ::Legends.Items.pickHelmet(::Legends.Items.convNameToList(this.Const.Items.NamedHelmets));
		else if (idx == 3)
			item = ::Legends.Items.pickArmor(::Legends.Items.convNameToList(this.Const.Items.NamedArmors));

		local cnh;

		if (idx == 1)
		{
			this.m.Flags.set("PrizeName", item.createRandomName());
			cnh = item.ClassNameHash;
		}
		else
		{
			local nameList = [];

			if ((item.m.ItemType & this.Const.Items.ItemType.Named) != 0)
				nameList.push(item);

			// getUpgrades lists for every layer slot if it is filled, the slot is the index and not the value
			foreach( i, filled in item.getUpgrades() )
			{
				if (filled != 1)
					continue;

				local u = item.getUpgrade(i);

				if (u != null && u.isItemType(this.Const.Items.ItemType.Named))
					nameList.push(u);
			}

			local idx = this.Math.rand(0, nameList.len() - 1);
			local item = nameList[idx];
			this.m.Flags.set("PrizeName", item.getName());
			cnh = item.ClassNameHash;
		}

		this.m.Flags.set("PrizeScript", cnh);

		if (item.isItemType(this.Const.Items.ItemType.Weapon))
			this.m.Flags.set("PrizeType", "weapon");
		else if (item.isItemType(this.Const.Items.ItemType.Shield))
			this.m.Flags.set("PrizeType", "shield");
		else if (item.isItemType(this.Const.Items.ItemType.Armor))
			this.m.Flags.set("PrizeType", "armor");
		else if (item.isItemType(this.Const.Items.ItemType.Helmet))
			this.m.Flags.set("PrizeType", "helmet");

		local homeTile = this.m.Home.getTile();
		local barbarians = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians);
		local camps = [];

		this.m.Flags.set("IsBarbarians", true);

		foreach( b in barbarians.getSettlements() )
		{
			if (b.isLocationType(this.Const.World.LocationType.Unique))
				continue;

			if (homeTile.getDistanceTo(b.getTile()) <= ::Mod_Sellswords.TreasureCampDistance)
				camps.push(b);
		}

		// the camps in range can be gone by the time the contract is looked at, the nearest one is used then
		local best = camps.len() != 0 ? ::MSU.Array.rand(camps) : barbarians.getNearestSettlement(homeTile);

		this.m.Destination = this.WeakTableRef(best);
		this.m.Flags.set("DestinationName", this.m.Destination.getName());
		this.m.Payment.Pool = 1200 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		this.m.Payment.Completion = 0.2;

		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Go and explore %location%, you'll get a famed %prizetype% called %prizename% as a bonus"
				];

				if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.IntroChance)
					this.Contract.setScreen("Intro");
				else
					this.Contract.setScreen("Task");
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				this.Contract.m.Destination.setLastSpawnTimeToNow();
				this.Contract.m.Destination.clearTroops();

				if (this.Contract.getDifficultyMult() <= 1.35 && !this.Contract.m.Destination.getFlags().get("IsEventLocation"))
					this.Contract.m.Destination.getLoot().clear();

				if (this.Flags.get("IsBandits"))
					this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.BanditBoss, 200 + 150 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				else if (this.Flags.get("IsBarbarians"))
					this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.Barbarians, 200 + 150 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				else if (this.Flags.get("IsOrientalBandits"))
					this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.NomadDefenders, 200 + 150 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				else if (this.Flags.get("IsOrcs"))
					this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.OrcBoss, 200 + 150 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				else if (this.Flags.get("IsGoblins"))
					this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.GoblinBoss, 200 + 150 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				else if (this.Flags.get("IsUndead"))
					this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.SsuRomaLegion, 150 + 135 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				else if (this.Flags.get("IsZombies"))	
					this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.Necromancer, 180 + 140 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());

				this.Contract.m.Destination.setLootScaleBasedOnResources(110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Destination.setDiscovered(true);
				this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);

				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
				}
			}
			function update()
			{
				if (this.Contract.m.Destination == null || this.Contract.m.Destination.isNull())
				{
					this.Contract.setScreen("ItemObtained");
					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
			}
			function onDestinationAttacked( _dest, _isPlayerAttacking = true )
			{
				local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
				p.CombatID = "BHattack";
				this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.BountyHunters, 40 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
				this.World.Contracts.startScriptedCombat(p, true, true, true);				
			}			
			
		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Return to " + this.Contract.m.Home.getName()
				];
				this.Contract.m.Home.getSprite("selection").Visible = true;
			}
			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					this.Contract.setScreen("Success1");
					this.World.Contracts.showActiveContract();
				}
			}	
		});
	}

	function createScreens()
	{
		this.importScreens(this.Const.Contracts.NegotiationDefault);
		this.importScreens(this.Const.Contracts.Overview);
		this.m.Screens.push({
			ID = "Task",
			Title = ::Mod_Sellswords.Strings.ssu_explore_treasures_contract.Title1,
			Text = ::Mod_Sellswords.Strings.ssu_explore_treasures_contract.Text1,
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_explore_treasures_contract.Text2,
					function getResult()
					{
						return ::Mod_Sellswords.Strings.ssu_explore_treasures_contract.Text3;
					}

				},
				{
					Text = ::Mod_Sellswords.Strings.ssu_explore_treasures_contract.Text4,
					function getResult()
					{
						this.World.Contracts.removeContract(this.Contract);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Approaching",
			Title = ::Mod_Sellswords.Strings.ssu_explore_treasures_contract.Title2,
			Text = ::Mod_Sellswords.Strings.ssu_explore_treasures_contract.Text5,
			Image = "",
			List = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_explore_treasures_contract.Text6,
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "ItemObtained",
			Title = ::Mod_Sellswords.Strings.ssu_explore_treasures_contract.Title3,
			Text = ::Mod_Sellswords.Strings.ssu_explore_treasures_contract.Text7,
			Image = "",
			List = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_explore_treasures_contract.Text8,
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{				
				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new(this.IO.scriptFilenameByHash(this.Flags.get("PrizeScript")));
				item.setName(this.Flags.get("PrizeName"));
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 12,
					icon = "ui/items/" + item.getIcon(),
					text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_explore_treasures_contract.Tooltip1, item.getName())
				});				
			}

		});		
		this.m.Screens.push({
			ID = "Success1",
			Title = ::Mod_Sellswords.Strings.ssu_explore_treasures_contract.Title4,
			Text = ::Mod_Sellswords.Strings.ssu_explore_treasures_contract.Text9,
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_explore_treasures_contract.Text10,
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Procured an artifact important for the war effort");						
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				local reward = this.Contract.m.Payment.getOnCompletion();
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_explore_treasures_contract.Tooltip2, this.Const.UI.Color.PositiveEventValue, reward)
				});
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/high_spirits_situation"), 3, this.Contract.m.Home, this.List);
			}			

		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"prizename",
			this.m.Flags.get("PrizeName")
		]);
		_vars.push([
			"prizetype",
			this.m.Flags.get("PrizeType")
		]);	
		_vars.push([
			"location",
			this.m.Flags.get("DestinationName")
		]);	
		_vars.push([
			"item",
			this.m.Flags.get("ItemName")
		]);		
		_vars.push([
			"direction",
			this.m.Destination == null || this.m.Destination.isNull() || !this.m.Destination.isAlive() ? "" : this.Const.Strings.Direction8[this.m.Home.getTile().getDirection8To(this.m.Destination.getTile())]
		]);
	}

	function onHomeSet()
	{
		if (this.m.SituationID == 0)
		{
			this.m.SituationID = this.m.Home.addSituation(this.new("scripts/entity/world/settlements/situations/ambushed_trade_routes_situation"));
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Destination != null && !this.m.Destination.isNull())
			{
				this.m.Destination.getSprite("selection").Visible = false;
				this.m.Destination.setOnCombatWithPlayerCallback(null);
			}

			this.m.Home.getSprite("selection").Visible = false;
		}

		if (this.m.Home != null && !this.m.Home.isNull() && this.m.SituationID != 0)
		{
			local s = this.m.Home.getSituationByInstance(this.m.SituationID);

			if (s != null)
			{
				s.setValidForDays(4);
			}
		}
	}

	function onIsValid()
	{
		if (this.m.IsStarted)
		{
			if (this.m.Destination == null || this.m.Destination.isNull() || !this.m.Destination.isAlive())
			{
				return false;
			}

			return true;
		}
		else
		{
			return true;
		}
	}

	function onSerialize( _out )
	{
		_out.writeI32(0);

		if (this.m.Destination != null && !this.m.Destination.isNull())
		{
			_out.writeU32(this.m.Destination.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		_in.readI32();
		local destination = _in.readU32();

		if (destination != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(destination));
		}

		this.contract.onDeserialize(_in);
	}

});