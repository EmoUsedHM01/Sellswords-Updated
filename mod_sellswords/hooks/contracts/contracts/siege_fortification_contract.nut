::Mod_Sellswords.HooksMod.hook("contracts/contracts/siege_fortification_contract", function(q)
{
	q.createStates = @( __original ) function()
	{
		__original();

		foreach (state in this.m.States)
		{
			switch(state.ID)
			{
			case "Running_NighttimeEncounter":
				state.onCombatVictory = function( _combatID )
				{
					if (_combatID == "NighttimeEncounter")
					{
						this.Flags.set("IsNighttimeEncounter", false);
						this.Flags.set("IsNighttimeEncounterAfermath", true);
					}
				}
				break;

			case "Running_SecretPassage":
				state.onSneakIn = function( _dest, _isPlayerAttacking = true )
				{
					if (!this.TempFlags.get("IsSecretPassageShown"))
					{
						this.TempFlags.set("IsSecretPassageShown", true);
						this.Contract.setScreen("SecretPassage");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "SecretPassage";
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
						this.Contract.flattenTerrain(p);
						p.Entities = [];
						p.EnemyBanners = [
							this.Contract.m.Origin.getOwner().getBannerSmall()
						];
						local dc = this.World.getTime().Days;
						dc = this.Math.min(dc, 300);
						if (dc < 150)
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
						}
						else if (dc >= 150)
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Nobleenhanced, (95 + 0.15 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
						}					
						p.Entities.push({
							ID = this.Const.EntityType.Knight,
							Variant = 0,
							Row = 2,
							Script = "scripts/entity/tactical/humans/knight",
							Faction = this.Contract.m.Origin.getOwner().getID(),
							Callback = this.onEnemyCommanderPlaced
						});
						this.World.Contracts.startScriptedCombat(p, false, true, true);
					}
				}
				break;

			case "Running_ReliefAttack":
				state.onCombatWithPlayer = function( _dest, _isPlayerAttacking = true )
				{
					_dest.setPos(this.World.State.getPlayer().getPos());
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "ReliefAttack";
					p.Music = this.Const.Music.NobleTracks;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.AllyBanners.push(this.World.FactionManager.getFaction(this.Contract.getFaction()).getBannerSmall());
					p.EnemyBanners.push(_dest.getBanner());
					this.Contract.flattenTerrain(p);
					local alliesIncluded = false;

					for( local i = 0; i < p.Entities.len(); i = i )
					{
						if (this.World.FactionManager.isAlliedWithPlayer(p.Entities[i].Faction))
						{
							alliesIncluded = true;
						}

						i = ++i;
					}

					if (!alliesIncluded && _dest.getDistanceTo(this.Contract.m.Origin) <= 400)
					{
						local dc = this.World.getTime().Days;
						dc = this.Math.min(dc, 300);
						if (dc < 150)
						{				
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
						}
						else if (dc >= 150)
						{				
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Nobleenhanced, (75 + 0.1 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
						}					
						foreach( id in this.Contract.m.UnitsSpawned )
						{
							local e = this.World.getEntityByID(id);

							if (e.isAlliedWithPlayer())
							{
								e.die();
								break;
							}
						}
					}

					this.World.Contracts.startScriptedCombat(p, false, true, true);
				}
				break;
			}
		}
	}

	q.createScreens = @( __original ) function()
	{
		__original();

		foreach (screen in this.m.Screens)
		{
			switch(screen.ID)
			{
			case "AssaultTheGate":
				::Mod_Sellswords.HookHelper.getOptionInEventScreen("Charge!", screen).getResult = function()
				{
					local tile = this.Contract.m.Origin.getTile();
					this.World.State.getPlayer().setPos(tile.Pos);
					this.World.getCamera().moveToPos(this.World.State.getPlayer().getPos());
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "AssaultTheGate";
					p.Music = this.Const.Music.NobleTracks;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
					this.Contract.flattenTerrain(p);
					p.Entities = [];
					p.AllyBanners = [];
					p.EnemyBanners = [
						this.Contract.m.Origin.getOwner().getBannerSmall()
					];
					local dc = this.World.getTime().Days;
					dc = this.Math.min(dc, 300);	
					if (dc < 150)
					{							
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
					}
					if (dc >= 150)
					{							
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Nobleenhanced, (95 + 0.15 * dc)* this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
					}						
					this.World.Contracts.startScriptedCombat(p, false, true, true);
					return 0;
				}
				break;

			case "BurnTheCastle":
				::Mod_Sellswords.HookHelper.getOptionInEventScreen("Charge!", screen).getResult = function()
				{
					local tile = this.Contract.m.Origin.getTile();
					this.World.State.getPlayer().setPos(tile.Pos);
					this.World.getCamera().moveToPos(this.World.State.getPlayer().getPos());
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "BurnTheCastle";
					p.Music = this.Const.Music.NobleTracks;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
					this.Contract.flattenTerrain(p);
					p.Entities = [];
					p.AllyBanners = [
						this.World.Assets.getBanner(),
						this.World.FactionManager.getFaction(this.Contract.getFaction()).getBannerSmall()
					];
					p.EnemyBanners = [
						this.Contract.m.Origin.getOwner().getBannerSmall()
					];
					local dc = this.World.getTime().Days;
					dc = this.Math.min(dc, 300);	
					if (dc < 150)
					{							
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
					}
					if (dc >= 150)
					{							
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Nobleenhanced, (75 + 0.1 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
					}						
					p.Entities.push({
						ID = this.Const.EntityType.Knight,
						Variant = 0,
						Row = 2,
						Script = "scripts/entity/tactical/humans/knight",
						Faction = this.Contract.getFaction(),
						Callback = this.Contract.onCommanderPlaced.bindenv(this.Contract),
						Tag = this.Contract
					});
					local dc = this.World.getTime().Days;
					dc = this.Math.min(dc, 300);	
					if (dc < 150)
					{							
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 200 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
					}
					if (dc >= 150)
					{							
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Nobleenhanced, (175 + 0.25 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
					}						
					p.Entities.push({
						ID = this.Const.EntityType.Knight,
						Variant = 0,
						Row = 2,
						Script = "scripts/entity/tactical/humans/knight",
						Faction = this.Contract.m.Origin.getOwner().getID(),
						Callback = null
					});
					this.World.Contracts.startScriptedCombat(p, false, true, true);
					return 0;
				}
				break;

			case "AssaultTheCourtyard":
				::Mod_Sellswords.HookHelper.getOptionInEventScreen("Charge!", screen).getResult = function()
				{
					local tile = this.Contract.m.Origin.getTile();
					this.World.State.getPlayer().setPos(tile.Pos);
					this.World.getCamera().moveToPos(this.World.State.getPlayer().getPos());
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "AssaultTheCourtyard";
					p.Music = this.Const.Music.NobleTracks;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
					this.Contract.flattenTerrain(p);
					p.Entities = [];
					p.AllyBanners = [];
					p.EnemyBanners = [
						this.Contract.m.Origin.getOwner().getBannerSmall()
					];
					local dc = this.World.getTime().Days;
					dc = this.Math.min(dc, 300);	
					if (dc < 150)
					{							
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
					}
					if (dc >= 150)
					{							
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Nobleenhanced, (105 + 0.15 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
					}						
					this.World.Contracts.startScriptedCombat(p, false, true, true);
					return 0;
				}
				break;

			case "NighttimeEncounter":
				::Mod_Sellswords.HookHelper.getOptionInEventScreen("Get them!", screen).getResult = function()
				{
					local tile = this.Contract.m.Origin.getTile();
					this.World.State.getPlayer().setPos(tile.Pos);
					this.World.getCamera().moveToPos(this.World.State.getPlayer().getPos());
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "NighttimeEncounter";
					p.Music = this.Const.Music.NobleTracks;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
					this.Contract.flattenTerrain(p);
					p.Entities = [];
					p.EnemyBanners = [
						this.Contract.m.Origin.getOwner().getBannerSmall()
					];
					local dc = this.World.getTime().Days;
					dc = this.Math.min(dc, 300);	
					if (dc < 150)
					{							
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
					}
					if (dc >= 150)
					{							
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Nobleenhanced, (75 + 0.1 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
					}						
					this.World.Contracts.startScriptedCombat(p, false, true, true);
					return 0;
				}
				break;

			case "NighttimeEncounterFail":
				::Mod_Sellswords.HookHelper.getOptionInEventScreen("Damn it!", screen).getResult = function()
				{
					this.Flags.set("IsNighttimeEncounter", false);
					this.Flags.set("IsReliefAttack", true);
					this.Flags.set("WaitUntil", this.Time.getVirtualTimeF() + this.Math.rand(15, 30));
					return 0;
				}
				break;

			case "DefendersSallyForth":
				::Mod_Sellswords.HookHelper.getOptionInEventScreen("Let\'s end this!", screen).getResult = function()
				{
					local tile = this.Contract.m.Origin.getTile();
					this.World.State.getPlayer().setPos(tile.Pos);
					this.World.getCamera().moveToPos(this.World.State.getPlayer().getPos());
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "DefendersSallyForth";
					p.Music = this.Const.Music.NobleTracks;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
					this.Contract.flattenTerrain(p);
					p.Entities = [];
					p.AllyBanners = [
						this.World.Assets.getBanner(),
						this.World.FactionManager.getFaction(this.Contract.getFaction()).getBannerSmall()
					];
					p.EnemyBanners = [
						this.Contract.m.Origin.getOwner().getBannerSmall()
					];
					local dc = this.World.getTime().Days;
					dc = this.Math.min(dc, 300);	
					if (dc < 150)
					{							
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 90 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
					}
					if (dc >= 150)
					{							
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Nobleenhanced, (80 + 0.1 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
					}						
					p.Entities.push({
						ID = this.Const.EntityType.Knight,
						Variant = 0,
						Row = 2,
						Script = "scripts/entity/tactical/humans/knight",
						Faction = this.Contract.getFaction(),
						Callback = this.Contract.onCommanderPlaced.bindenv(this.Contract)
					});
					local dc = this.World.getTime().Days;
					dc = this.Math.min(dc, 300);	
					if (dc < 150)
					{							
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 200 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
					}
					if (dc >= 150)
					{							
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Nobleenhanced, (175 + 0.25 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
					}						
					p.Entities.push({
						ID = this.Const.EntityType.Knight,
						Variant = 0,
						Row = 2,
						Script = "scripts/entity/tactical/humans/knight",
						Faction = this.Contract.m.Origin.getOwner().getID(),
						Callback = null
					});
					this.Contract.setState("Running_DefendersSallyForth");
					this.World.Contracts.startScriptedCombat(p, false, true, true);
					return 0;
				}
				break;
			}
		}
	}

	q.spawnReliefForces = @( __original ) function()
	{
		local tile;
		local originTile = this.m.Origin.getTile();

		while (true)
		{
			local x = this.Math.rand(originTile.SquareCoords.X - 8, originTile.SquareCoords.X + 8);
			local y = this.Math.rand(originTile.SquareCoords.Y - 8, originTile.SquareCoords.Y + 8);

			if (!this.World.isValidTileSquare(x, y))
			{
				continue;
			}

			tile = this.World.getTileSquare(x, y);

			if (tile.getDistanceTo(originTile) <= 4)
			{
				continue;
			}

			if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Mountains)
			{
				continue;
			}

			break;
		}

		local enemyFaction = this.m.Origin.getOwner();
		local dc = this.World.getTime().Days;
		dc = this.Math.min(dc, 300);
		local party;
		if (dc < 150)
		{			
			party = enemyFaction.spawnEntity(tile, this.m.Origin.getOwner().getName() + " Army", true, this.Const.World.Spawn.Noble, 200 * this.getDifficultyMult() * this.getScaledDifficultyMult());
		}
		if (dc >= 150)
		{			
			party = enemyFaction.spawnEntity(tile, this.m.Origin.getOwner().getName() + " Army", true, this.Const.World.Spawn.Nobleenhanced, (175 + 0.25 * dc) * this.getDifficultyMult() * this.getScaledDifficultyMult());
		}		
		party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + enemyFaction.getBannerString());
		party.getSprite("banner").setBrush(enemyFaction.getBannerSmall());
		party.setDescription("Professional soldiers in service to local lords.");
		party.setFootprintType(this.Const.World.FootprintsType.Nobles);
		party.getLoot().Money = this.Math.rand(100, 300);
		party.getLoot().ArmorParts = this.Math.rand(10, 35);
		party.getLoot().Medicine = this.Math.rand(5, 15);
		party.getLoot().Ammo = this.Math.rand(10, 40);
		local r = this.Math.rand(1, 4);

		if (r == 1)
		{
			party.addToInventory("supplies/bread_item");
		}
		else if (r == 2)
		{
			party.addToInventory("supplies/roots_and_berries_item");
		}
		else if (r == 3)
		{
			party.addToInventory("supplies/dried_fruits_item");
		}
		else if (r == 4)
		{
			party.addToInventory("supplies/ground_grains_item");
		}

		party.setAttackableByAI(false);
		this.m.UnitsSpawned.push(party.getID());
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(originTile);
		c.addOrder(move);
		local wait = this.new("scripts/ai/world/orders/wait_order");
		wait.setTime(10.0);
		c.addOrder(wait);
	}

	q.spawnSupplyCaravan = @( __original ) function()
	{
		local tile;
		local originTile = this.m.Origin.getTile();

		while (true)
		{
			local x = this.Math.rand(originTile.SquareCoords.X - 7, originTile.SquareCoords.X + 7);
			local y = this.Math.rand(originTile.SquareCoords.Y - 7, originTile.SquareCoords.Y + 7);

			if (!this.World.isValidTileSquare(x, y))
			{
				continue;
			}

			tile = this.World.getTileSquare(x, y);

			if (tile.getDistanceTo(originTile) <= 4)
			{
				continue;
			}

			if (!tile.HasRoad)
			{
				continue;
			}

			break;
		}

		local enemyFaction = this.m.Origin.getOwner();
		local dc = this.World.getTime().Days;
		local party;
		dc = this.Math.min(dc, 300);	
		if (dc < 150)
		{			
			party = enemyFaction.spawnEntity(tile, "Supply Caravan", false, this.Const.World.Spawn.NobleCaravan, this.Math.rand(100, 150));
		}
		else if (dc >= 150)
		{			
			party = enemyFaction.spawnEntity(tile, "Supply Caravan", false, this.Const.World.Spawn.NobleCaravan, this.Math.rand(135, 180));
		}		
		party.getSprite("base").Visible = false;
		party.setMirrored(true);
		party.setDescription("A caravan with armed escorts transporting provisions, supplies and equipment between settlements.");
		party.addToInventory("supplies/ground_grains_item");
		party.addToInventory("supplies/ground_grains_item");
		party.addToInventory("supplies/ground_grains_item");
		party.addToInventory("supplies/ground_grains_item");
		party.getLoot().Money = this.Math.rand(0, 100);
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(originTile);
		move.setRoadsOnly(true);
		c.addOrder(move);
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(despawn);
	}

	q.spawnSiege = @( __original ) function()
	{
		this.m.SituationID = this.m.Origin.addSituation(this.new("scripts/entity/world/settlements/situations/besieged_situation"));

		foreach( a in this.m.Origin.getActiveAttachedLocations() )
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				a.spawnFireAndSmoke();
				a.setActive(false);
			}
		}

		local f = this.World.FactionManager.getFaction(this.getFaction());
		local castles = [];

		foreach( s in f.getSettlements() )
		{
			if (s.isMilitary())
			{
				castles.push(s);
			}
		}

		if (castles.len() == 0)
		{
			castles = clone f.getSettlements();
		}

		local originTile = this.m.Origin.getTile();
		local lastTile;

		for( local i = 0; i < 2; i = i )
		{
			local tile;

			while (true)
			{
				local x = this.Math.rand(originTile.SquareCoords.X - 1, originTile.SquareCoords.X + 1);
				local y = this.Math.rand(originTile.SquareCoords.Y - 1, originTile.SquareCoords.Y + 1);

				if (!this.World.isValidTileSquare(x, y))
				{
					continue;
				}

				tile = this.World.getTileSquare(x, y);

				if (tile.getDistanceTo(originTile) == 0)
				{
					continue;
				}

				if (tile.Type == this.Const.World.TerrainType.Ocean)
				{
					continue;
				}

				if (i == 0 && !tile.HasRoad && !this.m.Origin.isIsolatedFromRoads())
				{
					continue;
				}

				if (lastTile != null && tile.ID == lastTile.ID)
				{
					continue;
				}

				break;
			}

			lastTile = tile;
			local dc = this.World.getTime().Days;
			dc = this.Math.min(dc, 300);
			local party;
			if (dc < 150)
			{					
				party = f.spawnEntity(tile, castles[this.Math.rand(0, castles.len() - 1)].getName() + " Company", true, this.Const.World.Spawn.Noble, castles[this.Math.rand(0, castles.len() - 1)].getResources());
			}
			else if (dc >= 150)
			{					
				party = f.spawnEntity(tile, castles[this.Math.rand(0, castles.len() - 1)].getName() + " Company", true, this.Const.World.Spawn.Nobleenhanced, castles[this.Math.rand(0, castles.len() - 1)].getResources());
			}			
			party.setDescription("Professional soldiers in service to local lords.");
			party.setVisibilityMult(2.5);

			if (i == 0)
			{
				party.getSprite("body").setBrush("figure_siege_01");
				party.getSprite("base").Visible = false;
			}
			else
			{
				party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
			}

			party.setAttackableByAI(false);
			this.m.UnitsSpawned.push(party.getID());
			this.m.Allies.push(party.getID());
			party.getLoot().Money = this.Math.rand(50, 200);
			party.getLoot().ArmorParts = this.Math.rand(0, 25);
			party.getLoot().Medicine = this.Math.rand(0, 5);
			party.getLoot().Ammo = this.Math.rand(0, 30);
			local r = this.Math.rand(1, 4);

			if (r == 1)
			{
				party.addToInventory("supplies/bread_item");
			}
			else if (r == 2)
			{
				party.addToInventory("supplies/roots_and_berries_item");
			}
			else if (r == 3)
			{
				party.addToInventory("supplies/dried_fruits_item");
			}
			else if (r == 4)
			{
				party.addToInventory("supplies/ground_grains_item");
			}

			local c = party.getController();
			c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
			c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
			local wait = this.new("scripts/ai/world/orders/wait_order");
			wait.setTime(9000.0);
			c.addOrder(wait);
			i = ++i;
		}
	}

});
