::mods_hookExactClass("contracts/contracts/last_stand_contract", function(o)
{
	o.spawnWave = function()
	{
		local undeadBase = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getNearestSettlement(this.m.Origin.getTile());
		local originTile = this.m.Origin.getTile();
		local tile;

		while (true)
		{
			local x = this.Math.rand(originTile.SquareCoords.X - 5, originTile.SquareCoords.X + 5);
			local y = this.Math.rand(originTile.SquareCoords.Y - 5, originTile.SquareCoords.Y + 5);

			if (!this.World.isValidTileSquare(x, y))
			{
				continue;
			}

			tile = this.World.getTileSquare(x, y);

			if (tile.getDistanceTo(originTile) <= 4)
			{
				continue;
			}

			if (tile.Type == this.Const.World.TerrainType.Ocean)
			{
				continue;
			}

			local navSettings = this.World.getNavigator().createSettings();
			navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;
			local path = this.World.getNavigator().findPath(tile, originTile, navSettings, 0);

			if (!path.isEmpty())
			{
				break;
			}
		}
		
		local dc = this.World.getTime().Days;
		local party;
		dc = this.Math.min(dc, 300);	
		if (dc < 150)
		{	
			party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).spawnEntity(tile, "Undead Horde", false, this.Const.World.Spawn.UndeadArmy, (80 + this.m.Flags.get("Wave") * 10) * this.getDifficultyMult() * this.getScaledDifficultyMult());
		}
		if (dc >= 150)
		{	
			party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).spawnEntity(tile, "Undead Horde", false, this.Const.World.Spawn.UndeadScourgeenhanced, (90 + this.m.Flags.get("Wave") * 15) * this.getDifficultyMult() * this.getScaledDifficultyMult());
		}		
		this.m.UnitsSpawned.push(party.getID());
		party.getLoot().ArmorParts = this.Math.rand(0, 15);
		party.getSprite("banner").setBrush(undeadBase.getBanner());
		party.setDescription("A legion of walking dead, back to claim from the living what was once theirs.");
		party.setFootprintType(this.Const.World.FootprintsType.Undead);
		party.setSlowerAtNight(false);
		party.setUsingGlobalVision(false);
		party.setLooting(false);
		party.setAttackableByAI(false);
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(originTile);
		c.addOrder(move);
		local attack = this.new("scripts/ai/world/orders/attack_zone_order");
		attack.setTargetTile(originTile);
		c.addOrder(attack);
		local destroy = this.new("scripts/ai/world/orders/convert_order");
		destroy.setTime(60.0);
		destroy.setSafetyOverride(true);
		destroy.setTargetTile(originTile);
		destroy.setTargetID(this.m.Origin.getID());
		c.addOrder(destroy);
	}

	o.spawnUndeadAtTheWalls = function()
	{
		local undeadBase = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getNearestSettlement(this.m.Origin.getTile());
		local dc = this.World.getTime().Days;
		local party;
		dc = this.Math.min(dc, 300);	
		if (dc < 150)
		{			
			party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).spawnEntity(this.m.Origin.getTile(), "Undead Horde", false, this.Const.World.Spawn.ZombiesOrZombiesAndGhosts, 100 * this.getDifficultyMult() * this.getScaledDifficultyMult());
		}
		if (dc >= 150)
		{			
			party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).spawnEntity(this.m.Origin.getTile(), "Undead Horde", false, this.Const.World.Spawn.ZombiesOrZombiesAndGhosts, 120 * this.getDifficultyMult() * this.getScaledDifficultyMult());
		}		
		party.setPos(this.createVec(party.getPos().X - 50, party.getPos().Y - 50));
		this.m.UnitsSpawned.push(party.getID());
		party.getLoot().ArmorParts = this.Math.rand(0, 15);
		party.getSprite("banner").setBrush(undeadBase.getBanner());
		party.setDescription("A legion of walking dead, back to claim from the living what was once theirs.");
		party.setFootprintType(this.Const.World.FootprintsType.Undead);
		party.setSlowerAtNight(false);
		party.setUsingGlobalVision(false);
		party.setLooting(false);
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		local wait = this.new("scripts/ai/world/orders/wait_order");
		wait.setTime(15.0);
		c.addOrder(wait);
		local destroy = this.new("scripts/ai/world/orders/convert_order");
		destroy.setTime(90.0);
		destroy.setSafetyOverride(true);
		destroy.setTargetTile(this.m.Origin.getTile());
		destroy.setTargetID(this.m.Origin.getID());
		c.addOrder(destroy);
	}
})