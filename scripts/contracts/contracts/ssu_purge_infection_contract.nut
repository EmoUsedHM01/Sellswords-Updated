this.ssu_purge_infection_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Settlement = null,
		temproster = null,
		temprostercbt = null,
		Category = ::Const.Contracts.Categories.Battle
	},
	function setSettlement( _s )
	{
		this.m.Flags.set("SettlementName", _s.getName());
		this.m.Settlement = this.WeakTableRef(_s);
	}

	function setLocation( _l )
	{
		this.m.Destination = this.WeakTableRef(_l);
		this.m.Flags.set("DestinationName", _l.getName());
	}

	function create()
	{
		this.contract.create();
		local r = this.Math.rand(1, 100);
		
		if (r <= 20)
			this.m.DifficultyMult = this.Math.rand(90, 105) * 0.01;
		else if (r <= 80)
			this.m.DifficultyMult = this.Math.rand(115, 135) * 0.01;
		else
			this.m.DifficultyMult = this.Math.rand(145, 165) * 0.01;

		this.m.Type = "contract.purge_infection";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_purge_infection_contract.Name;
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		local s = this.World.EntityManager.getSettlements()[this.Math.rand(0, this.World.EntityManager.getSettlements().len() - 1)];

		while(s.getAttachedLocations().len() == 0)
			s = this.World.EntityManager.getSettlements()[this.Math.rand(0, this.World.EntityManager.getSettlements().len() - 1)];

		this.logDebug("------raze_attached_location_contract getAttachedLocations's nunm: " + s.getAttachedLocations().len());
		this.m.Destination = this.WeakTableRef(s.getAttachedLocations()[this.Math.rand(0, s.getAttachedLocations().len() - 1)]);
		
		this.m.Flags.set("NecroEscaped", 0);
		this.m.Flags.set("IsDone", false);
		this.m.DescriptionTemplates = [
			"The dead rise in %s, spreading fear and chaos. Purge the undead and restore peace to the town.",
			"From the town of %s emerges a threat of the undead. Cleanse the area and reclaim the town.",
			"Behold, the rise of the undead in %s. Your mission: to eradicate this unholy menace and bring safety.",
			"The streets of %s are overrun with the undead. A sellsword is needed to purge this blight and restore order.",
			"The restless dead have emerged in %s, spreading terror. Rid the town of these horrors and bring peace.",
			"An undead horde threatens %s. Your task: to eliminate the undead and ensure the safety of its people."
		];
	}

	function formatDescription()
	{
		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);

		if (r.find("%") != null)
			r = this.format(r, ::Const.UI.getColorized(this.m.Destination.getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));

		this.m.Description = r;
	}

	function onImportIntro()
	{
		this.importNobleIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 1800 * this.getPaymentMult() * this.getDifficultyMult() * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Purge the scourge at " + this.Flags.get("DestinationName") + " near " + this.Flags.get("SettlementName"),
					"Do not let any necromancers escape"
				];

				if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.IntroChance)
				{
					this.Contract.setScreen("Intro");
				}
				else
				{
					this.Contract.setScreen("Task");
				}
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
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
					this.Contract.m.Destination.setFaction(this.Const.Faction.Enemy);
					this.Contract.m.Destination.setAttackable(true);
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (this.Flags.get("IsDone"))
				{
					this.Contract.setScreen("Done");
					this.World.Contracts.showActiveContract();
				}
			}

			function onEntityPlaced( _entity, _tag )
			{
				if (_entity.getFlags().has("Necro"))
				{
					_entity.setMoraleState(this.Const.MoraleState.Fleeing);
					_entity.getBaseProperties().Bravery = 0;
					_entity.getSkills().update();
					_entity.getAIAgent().addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat_always"));
				}
			}

			function onDestinationAttacked( _dest, _isPlayerAttacking = true )
			{
				if (!this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("IsAttackDialogTriggered", true);
					this.Contract.setScreen("DefaultAttack");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					local p = this.World.State.getLocalCombatProperties(this.Contract.m.Destination.getPos());
					p.CombatID = "PURGEEE";
					p.TemporaryEnemies = [
						this.Contract.getFaction()
					];
					p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[this.Contract.m.Destination.getTile().Type];
					p.Tile = this.World.getTile(this.World.worldToTile(this.World.State.getPlayer().getPos()));
					p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
					p.LocationTemplate.Template[0] = "tactical.human_camp";
					this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.SsuZombieMilitary, 80 + this.Math.rand(115, 125) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
					p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.None;
					p.LocationTemplate.CutDownTrees = true;
					p.LocationTemplate.AdditionalRadius = 5;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Edge;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Center;
					p.Music = this.Const.Music.UndeadTracks;
					p.IsAutoAssigningBases = false;
					p.IsFogOfWarVisible = false;
					this.Contract.m.temprostercbt = this.World.Assets.m.BrothersMaxInCombat;
					this.Contract.m.temproster = this.World.Assets.m.BrothersMax;
					this.World.Assets.m.BrothersMaxInCombat = 27;
					p.EnemyBanners = [
						this.World.FactionManager.getFaction(this.Contract.getFaction()).getPartyBanner()
					];
					foreach( e in p.Entities )
						e.Callback <- this.onEntityPlaced.bindenv(this);

					this.World.Contracts.startScriptedCombat(p, false, true, true);
				}
			}

			function onActorRetreated( _actor, _combatID )
			{
				if (_actor.getFlags().has("Necro"))
					this.Flags.set("NecroEscaped", this.Flags.get("NecroEscaped") + 1);
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "PURGEEE")
					this.Flags.set("IsDone", true);
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "PURGEEE")
					this.Flags.set("NecroEscaped", 100);
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Return to " + this.Contract.m.Home.getName()
				];
				this.Contract.m.Destination.getSprite("selection").Visible = false;
				this.Contract.m.Home.getSprite("selection").Visible = true;
				this.Contract.m.Destination.setOnCombatWithPlayerCallback(null);
				this.Contract.m.Destination.setFaction(this.Contract.m.Destination.getSettlement().getFaction());
				this.Contract.m.Destination.clearTroops();
			}

			function update()
			{
				this.World.Assets.m.BrothersMaxInCombat = this.Contract.m.temproster;
				this.World.Assets.m.BrothersMax = this.Contract.m.temprostercbt;								
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					if (this.Flags.get("NecroEscaped") == 0)
					{
						this.Contract.setScreen("Success1");
					}
					else
					{
						this.Contract.setScreen("Failure1");
					}

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
			Title = ::Mod_Sellswords.Strings.ssu_purge_infection_contract.Title1,
			Text = ::Mod_Sellswords.Strings.ssu_purge_infection_contract.Text1,
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_purge_infection_contract.Text2,
					function getResult()
					{
						return ::Mod_Sellswords.Strings.ssu_purge_infection_contract.Text3;
					}

				},
				{
					Text = ::Mod_Sellswords.Strings.ssu_purge_infection_contract.Text4,
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
			ID = "DefaultAttack",
			Title = ::Mod_Sellswords.Strings.ssu_purge_infection_contract.Title2,
			Text = ::Mod_Sellswords.Strings.ssu_purge_infection_contract.Text5,
			Image = "",
			List = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_purge_infection_contract.Text6,
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						
						for( local i = 0; i != 2; i = ++i )
						{
							local paladin;
							paladin = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_paladin_guest");							
							paladin.setFaction(this.Contract.getFaction());	
							paladin.setPlaceInFormation(28 + i);							
							paladin.assignRandomEquipment();
							paladin.setFaction(1);	
						}							
						
						return 0;
					}

				}
			]			
		});
		this.m.Screens.push({
			ID = "Done",
			Title = ::Mod_Sellswords.Strings.ssu_purge_infection_contract.Title3,
			Text = ::Mod_Sellswords.Strings.ssu_purge_infection_contract.Text7,
			Image = "",
			List = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_purge_infection_contract.Text8,
					function getResult()
					{
						this.World.Assets.addMoralReputation(-5);
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = ::Mod_Sellswords.Strings.ssu_purge_infection_contract.Title4,
			Text = ::Mod_Sellswords.Strings.ssu_purge_infection_contract.Text9,
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_purge_infection_contract.Text10,
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "Purged the infection");
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_purge_infection_contract.Tooltip, this.Const.UI.Color.PositiveEventValue, this.Contract.m.Payment.getOnCompletion())
				});
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/terrified_villagers_situation"), 3, this.Contract.m.Settlement, this.List);	
			}

		});
		this.m.Screens.push({
			ID = "Failure1",
			Title = ::Mod_Sellswords.Strings.ssu_purge_infection_contract.Title4,
			Text = ::Mod_Sellswords.Strings.ssu_purge_infection_contract.Text11,
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_purge_infection_contract.Text12,
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "Failed to purge the infection");						
						this.World.Contracts.finishActiveContract();
						return 0;
					}
				}
			],
			function start()
			{
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/terrified_villagers_situation"), 7, this.Contract.m.Settlement, this.List);	
			}			
		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"location",
			this.m.Flags.get("DestinationName")
		]);
		_vars.push([
			"settlementname",
			this.m.Flags.get("SettlementName")
		]);
		_vars.push([
			"noblehousename",
			this.World.FactionManager.getFaction(this.m.Faction).getNameOnly()
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Destination != null && !this.m.Destination.isNull())
			{
				this.m.Destination.getSprite("selection").Visible = false;
				this.m.Destination.setFaction(this.m.Destination.getSettlement().getFaction());
				this.m.Destination.setOnCombatWithPlayerCallback(null);
				this.m.Destination.setAttackable(false);
				this.m.Destination.clearTroops();
			}

			this.m.Home.getSprite("selection").Visible = false;
						
			this.World.getGuestRoster().clear();			
		}
	}

	function onIsValid()
	{
		if (this.World.FactionManager.isGreaterEvil())
		{
			return false;
		}

		if (this.m.Destination == null || this.m.Destination.isNull() || !this.m.Destination.isActive())
		{
			return false;
		}

		if (this.m.Settlement == null || this.m.Settlement.isNull())
		{
			return false;
		}

		return true;
	}

	function onSerialize( _out )
	{
		if (this.m.Destination != null && !this.m.Destination.isNull())
		{
			_out.writeU32(this.m.Destination.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		if (this.m.Settlement != null && !this.m.Settlement.isNull())
		{
			_out.writeU32(this.m.Settlement.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local dest = _in.readU32();

		if (dest != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(dest));
		}

		local settlement = _in.readU32();

		if (settlement != 0)
		{
			this.m.Settlement = this.WeakTableRef(this.World.getEntityByID(settlement));
		}

		this.contract.onDeserialize(_in);
	}

});