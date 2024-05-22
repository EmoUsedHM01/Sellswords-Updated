::mods_hookExactClass("contracts/contracts/deliver_item_contract", function(o)
{
	o.setup = function()
	{
		local settlements = this.World.EntityManager.getSettlements();
		local candidates = [];

		foreach( s in settlements )
		{
			if (s.getID() == this.m.Home.getID())
			{
				continue;
			}

			if (!s.isDiscovered() || s.isMilitary())
			{
				continue;
			}

			if (!s.isAlliedWithPlayer())
			{
				continue;
			}

			if (this.m.Home.isIsolated() || s.isIsolated() || !this.m.Home.isConnectedToByRoads(s) || this.m.Home.isCoastal() && s.isCoastal())
			{
				continue;
			}

			local d = this.m.Home.getTile().getDistanceTo(s.getTile());

			if (d < 15 || d > 100)
			{
				continue;
			}

			if (this.World.getTime().Days <= 10)
			{
				local distance = this.getDistanceOnRoads(this.m.Home.getTile(), s.getTile());
				local days = this.getDaysRequiredToTravel(distance, this.Const.World.MovementSettings.Speed, false);

				if (this.World.getTime().Days <= 5 && days >= 2)
				{
					continue;
				}

				if (this.World.getTime().Days <= 10 && days >= 3)
				{
					continue;
				}
			}

			candidates.push(s);
		}

		if (candidates.len() == 0)
		{
			this.m.IsValid = false;
			return;
		}

		this.m.Destination = this.WeakTableRef(candidates[this.Math.rand(0, candidates.len() - 1)]);
		local distance = this.getDistanceOnRoads(this.m.Home.getTile(), this.m.Destination.getTile());
		local days = this.getDaysRequiredToTravel(distance, this.Const.World.MovementSettings.Speed, false);
		local modrate = this.World.State.getPlayer().getBarterMult();

		if (days >= 2 || distance >= 40)
		{
			this.m.DifficultyMult = this.Math.rand(95, 105) * 0.01;
		}
		else
		{
			this.m.DifficultyMult = this.Math.rand(70, 85) * 0.01;
		}

		this.m.Payment.Pool = this.Math.max(150, distance * 1.25 * (1.0 + modrate) * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentLightMult());

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.m.Flags.set("Distance", distance);
	}

	local ws_createStates = o.createStates;
	o.createStates = function()
	{
		ws_createStates();

		foreach (state in this.m.States)
		{
			if (state.ID != "Running") continue;
			
			state.update = function()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Destination) && !this.Flags.get("IsStolenByThieves"))
				{
					if (this.Flags.get("IsEnragingMessage"))
					{
						this.Contract.setScreen("EnragingMessage1");
					}
					else
					{
						local isSouthern = this.Contract.m.Destination.isSouthern();

						if (isSouthern)
						{
							this.Contract.setScreen("Success2");
						}
						else
						{
							this.Contract.setScreen("Success1");
						}
					}

					this.World.Contracts.showActiveContract();
				}
				else
				{
					local parties = this.World.getAllEntitiesAtPos(this.World.State.getPlayer().getPos(), 400.0);

					foreach( party in parties )
					{
						if (!party.isAlliedWithPlayer)
						{
							return;
						}
					}

					if (this.Flags.get("IsMercenaries") && this.World.State.getPlayer().getTile().HasRoad)
					{
						if (!this.TempFlags.get("IsMercenariesDialogTriggered") && this.Contract.getDistanceToNearestSettlement() >= 6 && this.Math.rand(1, 1000) <= 1)
						{
							this.Contract.setScreen("Mercenaries1");
							this.World.Contracts.showActiveContract();
							this.TempFlags.set("IsMercenariesDialogTriggered", true);
						}
					}
					else if (this.Flags.get("IsEvilArtifact") && !this.Flags.get("IsEvilArtifactDone"))
					{
						if (!this.TempFlags.get("IsEvilArtifactDialogTriggered") && this.Contract.getDistanceToNearestSettlement() >= 6 && this.Math.rand(1, 1000) <= 1)
						{
							this.Contract.setScreen("EvilArtifact1");
							this.World.Contracts.showActiveContract();
							this.TempFlags.set("IsEvilArtifactDialogTriggered", true);
						}
					}
					else if (this.Flags.get("IsEvilArtifact") && this.Flags.get("IsEvilArtifactDone"))
					{
						this.Contract.setScreen("EvilArtifact3");
						this.World.Contracts.showActiveContract();
						this.Flags.set("IsEvilArtifact", false);
					}
					else if (this.Flags.get("IsThieves") && !this.Flags.get("IsStolenByThieves") && (this.World.Assets.isCamping() || !this.World.getTime().IsDaytime) && this.Math.rand(1, 100) <= 3)
					{
						local tile = this.Contract.getTileToSpawnLocation(this.World.State.getPlayer().getTile(), 5, 10, [
							this.Const.World.TerrainType.Shore,
							this.Const.World.TerrainType.Ocean,
							this.Const.World.TerrainType.Mountains
						], false);
						tile.clear();
						this.Contract.m.Location = this.WeakTableRef(this.World.spawnLocation("scripts/entity/world/locations/bandit_hideout_location", tile.Coords));
						this.Contract.m.Location.setResources(0);
						this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).addSettlement(this.Contract.m.Location.get(), false);
						this.Contract.m.Location.onSpawned();
						this.Contract.addUnitsToEntity(this.Contract.m.Location, this.Const.World.Spawn.BanditDefenders, 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						this.Const.World.Common.addFootprintsFromTo(this.World.State.getPlayer().getTile(), tile, this.Const.GenericFootprints, this.Const.World.FootprintsType.Brigands, 0.75);
						this.Flags.set("IsStolenByThieves", true);
						this.Contract.setScreen("Thieves1");
						this.World.Contracts.showActiveContract();
					}
				}
			}
		}
	}

	local ws_createScreens = o.createScreens;
	o.createScreens = function()
	{
		ws_createScreens();

		foreach (screen in this.m.Screens)
		{
			switch(screen.ID)
			{
			case "Mercenaries1":
				::Mod_Sellswords.HookHelper.getOptionInEventScreen("If you want it, come and take it!", screen).getResult = function()
				{
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "Mercs";
					p.Music = this.Const.Music.NobleTracks;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
					this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.MercenariesLOW, 120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
					this.World.Contracts.startScriptedCombat(p, false, true, true);
					return 0;
				}
				break;

			case "BountyHunters1":
				::Mod_Sellswords.HookHelper.getOptionInEventScreen("If you want it, come and take it!", screen).getResult = function()
				{
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "Mercs";
					p.Music = this.Const.Music.NobleTracks;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
					this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.MercenariesLOW, 140 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
					this.World.Contracts.startScriptedCombat(p, false, true, true);
					return 0;
				}
				break;

			case "Success1":
				::Mod_Sellswords.HookHelper.getOptionInEventScreen("Crowns well deserved.", screen).getResult = function()
				{
					this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
					this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
					local playerRoster = this.World.getPlayerRoster().getAll();
					local xp = this.Contract.m.Payment.getOnCompletion() * 0.25;

					foreach( bro in playerRoster )
					{
						bro.addXP(xp);
						bro.updateLevel();
					}

					if (this.World.FactionManager.getFaction(this.Contract.getFaction()).getType() == this.Const.FactionType.OrientalCityState)
					{
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "Delivered some cargo");
					}
					else
					{
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Delivered some cargo");
					}

					local recipientFaction = this.Contract.m.Destination.getFactionOfType(this.Const.FactionType.Settlement);

					if (recipientFaction != null)
					{
						recipientFaction.addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess * 0.5, "Delivered some cargo");
					}

					this.World.Contracts.finishActiveContract();
					return 0;
				}
				break;

			case "Success2":
				screen.start = function()
				{
					local xpGained = this.Math.round(this.Contract.m.Payment.getOnCompletion() * 0.15 * this.Const.Combat.GlobalXPMult);
					this.Characters.push(this.Tactical.getEntityByID(this.Contract.m.RecipientID).getImagePath());
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] Crowns and [color=" + this.Const.UI.Color.PositiveEventValue + "]" + xpGained + "[/color] Experience"
					});
				}

				::Mod_Sellswords.HookHelper.getOptionInEventScreen("Crowns well deserved.", screen).getResult = function()
				{
					this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
					this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
					local playerRoster = this.World.getPlayerRoster().getAll();
					local xp = this.Contract.m.Payment.getOnCompletion() * 0.15;

					foreach( bro in playerRoster )
					{
						bro.addXP(xp);
						bro.updateLevel();
					}

					if (this.World.FactionManager.getFaction(this.Contract.getFaction()).getType() == this.Const.FactionType.OrientalCityState)
					{
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "Delivered some cargo");
					}
					else
					{
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Delivered some cargo");
					}

					local recipientFaction = this.Contract.m.Destination.getFactionOfType(this.Const.FactionType.Settlement);

					if (recipientFaction != null)
					{
						recipientFaction.addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess * 0.5, "Delivered some cargo");
					}

					this.World.Contracts.finishActiveContract();
					return 0;
				}
				break;
			}
		}
	}
})