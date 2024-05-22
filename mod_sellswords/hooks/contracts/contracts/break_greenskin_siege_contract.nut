::Mod_Sellswords.HooksMod.hook("contracts/contracts/break_greenskin_siege_contract", function (q)
{
	q.createStates = @( __original ) function()
	{
		__original();

		foreach (state in this.m.States)
		{
			if (state.ID != "Offer") continue;
			
			state.end = function()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local okLocations = 0;

				foreach( l in this.Contract.m.Origin.getAttachedLocations() )
				{
					if (l.isActive())
					{
						okLocations = ++okLocations;
					}
				}

				if (okLocations < 3)
				{
					foreach( l in this.Contract.m.Origin.getAttachedLocations() )
					{
						if (!l.isActive() && !l.isMilitary())
						{
							l.setActive(true);
							okLocations = ++okLocations;

							if (okLocations >= 3)
							{
								break;
							}
						}
					}
				}

				local faction = this.World.FactionManager.getFaction(this.Contract.getFaction());
				local dc = this.World.getTime().Days;
				local party;
				dc = this.Math.min(dc, 300);	
				if (dc < 150)
				{						
					party = faction.spawnEntity(this.Contract.getHome().getTile(), this.Contract.getHome().getName() + " Company", true, this.Const.World.Spawn.Noble, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				}
				else if (dc >= 150)
				{						
					party = faction.spawnEntity(this.Contract.getHome().getTile(), this.Contract.getHome().getName() + " Company", true, this.Const.World.Spawn.Nobleenhanced, (95 + 0.15 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				}				
				party.getSprite("banner").setBrush(faction.getBannerSmall());
				party.setDescription("Professional soldiers in service to local lords.");
				this.Contract.m.Troops = this.WeakTableRef(party);
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
				local move = this.new("scripts/ai/world/orders/move_order");
				move.setDestination(this.Contract.getOrigin().getTile());
				c.addOrder(move);
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}
		}
	}

	q.spawnSiege = @(__original) function()
	{
		if (this.m.Flags.get("IsSiegeSpawned"))
		{
			return;
		}

		this.m.SituationID = this.m.Origin.addSituation(this.new("scripts/entity/world/settlements/situations/besieged_situation"));
		local originTile = this.m.Origin.getTile();
		local orcBase = this.World.getEntityByID(this.m.Flags.get("OrcBase"));
		local goblinBase = this.World.getEntityByID(this.m.Flags.get("GoblinBase"));
		local numSiegeEngines;

		if (this.m.DifficultyMult >= 1.15)
		{
			numSiegeEngines = this.Math.rand(1, 2);
		}
		else
		{
			numSiegeEngines = 1;
		}

		local numOtherEnemies;

		if (this.m.DifficultyMult >= 1.25)
		{
			numOtherEnemies = this.Math.rand(2, 3);
		}
		else if (this.m.DifficultyMult >= 0.95)
		{
			numOtherEnemies = 2;
		}
		else
		{
			numOtherEnemies = 1;
		}

		for( local i = 0; i < numSiegeEngines; i = ++i )
		{
			local tile;
			local tries = 0;

			while (tries++ < 500)
			{
				local x = this.Math.rand(originTile.SquareCoords.X - 2, originTile.SquareCoords.X + 2);
				local y = this.Math.rand(originTile.SquareCoords.Y - 2, originTile.SquareCoords.Y + 2);

				if (!this.World.isValidTileSquare(x, y))
				{
					continue;
				}

				tile = this.World.getTileSquare(x, y);

				if (tile.getDistanceTo(originTile) <= 1)
				{
					continue;
				}

				if (tile.Type == this.Const.World.TerrainType.Ocean)
				{
					continue;
				}

				if (tile.IsOccupied)
				{
					continue;
				}

				break;
			}
			local dc = this.World.getTime().Days;
			local party;
			dc = this.Math.min(dc, 300);	
			if (dc < 150)
			{	
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).spawnEntity(tile, "Siege Engines", false, this.Const.World.Spawn.GreenskinHorde, this.Math.rand(100, 120) * this.getDifficultyMult() * this.getScaledDifficultyMult());
			}
			if (dc >= 150)
			{	
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).spawnEntity(tile, "Siege Engines", false, this.Const.World.Spawn.GreenskinHordeenhanced, this.Math.rand(120, 150) * this.getDifficultyMult() * this.getScaledDifficultyMult());
			}			
			this.m.UnitsSpawned.push(party.getID());
			party.setDescription("A horde of greenskins and their siege engines.");
			local numSiegeUnits = this.Math.rand(3, 4);

			for( local j = 0; j < numSiegeUnits; j = ++j )
			{
				this.Const.World.Common.addTroop(party, {
					Type = this.Const.World.Spawn.Troops.GreenskinCatapult
				}, false);
			}

			party.updateStrength();
			party.getLoot().ArmorParts = this.Math.rand(0, 15);
			party.getLoot().Ammo = this.Math.rand(0, 10);
			party.addToInventory("supplies/strange_meat_item");
			party.getSprite("body").setBrush("figure_siege_01");
			party.getSprite("banner").setBrush(goblinBase != null ? goblinBase.getBanner() : "banner_goblins_01");
			party.getSprite("banner").Visible = false;
			party.getSprite("base").Visible = false;
			party.setAttackableByAI(false);
			party.getFlags().add("SiegeEngine");
			local c = party.getController();
			c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
			c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
			local wait = this.new("scripts/ai/world/orders/wait_order");
			wait.setTime(9000.0);
			c.addOrder(wait);
		}

		local targets = [];

		foreach( l in this.m.Origin.getAttachedLocations() )
		{
			if (l.isActive() && l.isUsable())
			{
				targets.push(l);
			}
		}

		if (targets.len() == 0)
		{
			foreach( l in this.m.Origin.getAttachedLocations() )
			{
				if (l.isUsable())
				{
					targets.push(l);
				}
			}
		}

		for( local i = 0; i < numOtherEnemies; i = ++i )
		{
			local tile;
			local tries = 0;

			while (tries++ < 500)
			{
				local x = this.Math.rand(originTile.SquareCoords.X - 4, originTile.SquareCoords.X + 4);
				local y = this.Math.rand(originTile.SquareCoords.Y - 4, originTile.SquareCoords.Y + 4);

				if (!this.World.isValidTileSquare(x, y))
				{
					continue;
				}

				tile = this.World.getTileSquare(x, y);

				if (tile.getDistanceTo(originTile) <= 1)
				{
					continue;
				}

				if (tile.Type == this.Const.World.TerrainType.Ocean)
				{
					continue;
				}

				break;
			}
			local dc = this.World.getTime().Days;
			local party;
			dc = this.Math.min(dc, 300);	
			if (dc < 150)
			{	
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).spawnEntity(tile, "Greenskin Horde", false, this.Const.World.Spawn.GreenskinHorde, this.Math.rand(90, 110) * this.getDifficultyMult() * this.getScaledDifficultyMult());
			}
			else if (dc >= 150)
			{	
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).spawnEntity(tile, "Greenskin Horde", false, this.Const.World.Spawn.GreenskinHordeenhanced, this.Math.rand(105, 130) * this.getDifficultyMult() * this.getScaledDifficultyMult());
			}			
			this.m.UnitsSpawned.push(party.getID());
			party.setDescription("A horde of greenskins marching to war.");
			party.getLoot().ArmorParts = this.Math.rand(0, 15);
			party.getLoot().Ammo = this.Math.rand(0, 10);
			party.addToInventory("supplies/strange_meat_item");
			party.getSprite("banner").setBrush(orcBase != null ? orcBase.getBanner() : "banner_orcs_01");
			local c = party.getController();
			local raidTarget = targets[this.Math.rand(0, targets.len() - 1)].getTile();
			c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
			local raid = this.new("scripts/ai/world/orders/raid_order");
			raid.setTime(30.0);
			raid.setTargetTile(raidTarget);
			c.addOrder(raid);
			local destroy = this.new("scripts/ai/world/orders/destroy_order");
			destroy.setTime(60.0);
			destroy.setSafetyOverride(true);
			destroy.setTargetTile(originTile);
			destroy.setTargetID(this.m.Origin.getID());
			c.addOrder(destroy);
		}

		if (this.m.Troops != null && !this.m.Troops.isNull())
		{
			local c = this.m.Troops.getController();
			c.clearOrders();
			local intercept = this.new("scripts/ai/world/orders/intercept_order");
			intercept.setTarget(this.World.getEntityByID(this.m.UnitsSpawned[this.m.UnitsSpawned.len() - 1]));
			c.addOrder(intercept);
			local guard = this.new("scripts/ai/world/orders/guard_order");
			guard.setTarget(originTile);
			guard.setTime(120.0);
		}

		this.m.Origin.spawnFireAndSmoke();
		this.m.Origin.setLastSpawnTimeToNow();
		this.m.Flags.set("IsSiegeSpawned", true);
	}
});
