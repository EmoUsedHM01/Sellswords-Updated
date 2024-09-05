this.mod_ai_flying_skulls_player <- ::inherit("scripts/ai/tactical/behavior", {
	m = {
		Tiles = [],
		Skulls = 0,
		Skill = null,
		PossibleSkills = [
			"effects.lorekeeper_skull_spawn"
		],
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.FlyingSkulls;
		this.m.Order = ::Const.AI.Behavior.Order.FlyingSkulls;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		// Function is a generator.
		this.m.Tiles = [];
		this.m.Skill = null;
		local scoreMult = this.getProperties().BehaviorMult[this.m.ID];
		this.m.Skill = _entity.getSkills().getSkillByID(this.m.PossibleSkills[0]);

		if (this.m.Skill == null)
			return ::Const.AI.Behavior.Score.Zero;

		// Adjust to use the level from the effect
		local effect = _entity.getSkills().getSkillByID("effects.lorekeeper_skull_spawn");
		local level = effect != null ? effect.m.Level : 0;

		if (level <= 0)
			return ::Const.AI.Behavior.Score.Zero;

		local faction = _entity.getFaction();
		local entities = ::Tactical.Entities.getInstancesOfFaction(faction == ::Const.Faction.Player ? ::Const.Faction.PlayerAnimals : faction);
		local skulls = 0;

		foreach( e in entities )
			if (e.getType() == ::Const.EntityType.FlyingSkull)
				skulls = ++skulls;

		if (skulls >= 12)
			return ::Const.AI.Behavior.Score.Zero;
		
		// Calculate the number of skulls to summon based on the level from the effect
		// I hard-set a "cap" of level 12 in the lorekeeper_skull_spawn_effect so it will summon a max of 3 skulls
		this.m.Skulls = ::Math.max(1, ::Math.floor(level / 4));

		if (this.m.Skulls <= 0)
			return ::Const.AI.Behavior.Score.Zero;

		local myTile = _entity.getTile();
		local tiles = [];
		local mapSize = ::Tactical.getMapSize();

		for( local x = 1; x < mapSize.X - 1; x = ++x )
		{
			for( local y = 1; y < mapSize.Y - 1; y = ++y )
			{
				local tile = ::Tactical.getTileSquare(x, y);

				if (!tile.IsEmpty)
				{
				}
				else
				{
					tiles.push({
						Tile = tile,
						Score = 0.0
					});
				}
			}
		}

		if (tiles.len() == 0)
			return ::Const.AI.Behavior.Score.Zero;

		local opponents = this.getAgent().getKnownOpponents();

		foreach (t in tiles)
		{
			local tile = t.Tile;
			local score = 0.0;
			local farthest = 9000;

			foreach (target in opponents)
			{
				if (target == null || target.Actor.isNull())
					continue;

				if (!target.Actor.isPlacedOnMap()) // Needs this because otherwise you can get bad inputs
					continue;

				local targetTile = target.Actor.getTile();

				// Check if both tiles are valid before calculating the distance
				if (tile != null && targetTile != null)
				{
					local d = tile.getDistanceTo(targetTile);

					if (d == null)
						continue;

					if (d <= 4)
						score -= 10.0;

					if (d < farthest)
						farthest = d;
				}
			}

			if (farthest > 6)
				score -= farthest;

			t.Score = score;
		}

		tiles.sort(this.onSortByScore);

		if (tiles[0].Score <= -10.0)
			return ::Const.AI.Behavior.Score.Zero;

		this.m.Tiles = tiles;
		return ::Const.AI.Behavior.Score.Zero * scoreMult;
	}

	function onExecute( _entity )
	{
		if (this.m.Tiles.len() != 0 && this.m.Skulls > 0)
		{
			local originalFaction = _entity.getFaction();
			local faction = originalFaction == ::Const.Faction.Player ? ::Const.Faction.PlayerAnimals : originalFaction;

			for(local i = 0; i < this.m.Skulls; ++i)
			{
				local tile = this.m.Tiles.remove(0).Tile;

				_entity.setDiscovered(true);
				_entity.getTile().addVisibilityForFaction(this.Const.Faction.Player);

				tile.addVisibilityForCurrentEntity();
				local tag = {
					User = _entity,
					Tile = tile
				};

				::Tactical.CameraDirector.pushMoveToTileEvent(100 + i * 200, tile, -1, function(_tag) 
				{
					local skull = ::Tactical.spawnEntity("scripts/entity/tactical/enemies/flying_skull", _tag.Tile.Coords.X, _tag.Tile.Coords.Y);
					skull.getFlags().set("Source", _tag.User.getID());
					skull.setFaction(faction);
					skull.addMoreHP(_entity);
					skull.getTile().addVisibilityForFaction(this.Const.Faction.Player);
				}.bindenv(this), tag, 200, ::Const.Tactical.Settings.CameraNextEventDelay + 50);

				::Tactical.CameraDirector.addDelay(0.1);

				if (this.m.Tiles.len() == 0)
					break;
			}

			this.m.Tiles = [];
			return true;
		}

		::Tactical.getCamera().moveToExactly(_entity);

		return false
	}

	function onSortByScore( _a, _b )
	{
		if (_a.Score > _b.Score)
			return -1;
		else if (_a.Score < _b.Score)
			return 1;

		return 0;
	}

});