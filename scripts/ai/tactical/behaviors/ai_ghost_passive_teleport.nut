this.ai_ghost_passive_teleport <- ::inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		SelectedSkill = null,
		PossibleSkills = [
			"actives.ghost_teleport"
		]
	},
	function create()
	{
		this.m.ID = 70;
		this.m.Order = 50;
		this.behavior.create();
	}

	function onEvaluate( _entity , _isForce = false )
	{
		local score = this.getProperties().BehaviorMult[this.m.ID];
		this.m.TargetTile = null;
		this.m.SelectedSkill = null;

		if (!_isForce)
			return ::Const.AI.Behavior.Score.Zero;

		local skills = [];

		foreach( skillID in this.m.PossibleSkills )
		{
			local skill = _entity.getSkills().getSkillByID(skillID);

			if (skill != null && skill.isUsable() && skill.isAffordable())
			{
				this.m.SelectedSkill = skill;
				break;
			}
		}

		if (this.m.SelectedSkill == null)
			return ::Const.AI.Behavior.Score.Zero;

		local myTile = _entity.getTile();
		local destinations = [];
		local potentialDestinations = [];
		this.getStrategy().cleanUpKnownOpponents();
		this.getStrategy().compileKnownOpponents();
		local targets = this.getAgent().getKnownOpponents();

		foreach( t in targets )
		{
			if (t.Actor.isNull())
				continue;

			local targetValue = this.queryTargetValue(_entity, t.Actor);

			if (t.Actor.getCurrentProperties().IsStunned || t.Actor.getCurrentProperties().IsRooted)
				targetValue *= 1.5;
			else if (t.Actor.isTurnDone())
				targetValue *= 1.15;

			local potentialTiles = this.queryDestinationsInRange(t.Actor.getTile(), this.getProperties().EngageRangeMin - 1, this.getProperties().EngageRangeMax - 1);

			foreach( tile in potentialTiles )
			{
				if (!tile.IsEmpty || tile.Type == ::Const.Tactical.TerrainType.Impassable)
					continue;

				local score = 60.0 + 40.0 * targetValue;
				score = score - tile.getZoneOfOccupationCountOtherThan(_entity.getAlliedFactions()) * 20.0;
				score = score + tile.TVTotal;
				score = score - (tile.Properties.Effect != null && tile.Properties.Effect.Type != "miasma" && !tile.Properties.Effect.IsPositive ? 40.0 : 0.0);

				foreach( o in targets )
				{
					if (o.Actor.isNull() || o.Actor.getID() == t.Actor.getID())
						continue;

					if (o.Actor.getMoraleState() == ::Const.MoraleState.Fleeing || o.Actor.getCurrentProperties().IsStunned || o.Actor.getCurrentProperties().IsRooted)
						continue;

					local d = o.Actor.getTile().getDistanceTo(tile);

					if (d <= 3)
						score = score - 5.0;
				}

				destinations.push({
					Tile = tile,
					Score = score
				});
			}
		}

		foreach( pd in destinations )
		{
			if (!pd.Tile.IsEmpty || pd.Tile.Type == ::Const.Tactical.TerrainType.Impassable)
				continue;

			local score = pd.Score;

			for( local i = 0; i < 6; i = ++i )
			{
				if (!pd.Tile.hasNextTile(i))
				{
				}
				else
				{
					local nextTile = pd.Tile.getNextTile(i);

					if (nextTile.IsOccupiedByActor && nextTile.getEntity().getFlags().has("ghost_fragment"))
						score = score - 20.0;
				}
			}

			potentialDestinations.push({
				Tile = pd.Tile,
				Score = score
			});
		}

		if (potentialDestinations.len() == 0)
			return ::Const.AI.Behavior.Score.Zero;

		potentialDestinations.sort(this.onSortByScore);
		this.m.TargetTile = potentialDestinations[0].Tile;
		return ::Const.AI.Behavior.Score.Zero;
	}

	function onExecute( _entity )
	{
		if (this.m.TargetTile != null)
		{
			this.m.SelectedSkill.use(this.m.TargetTile, true);
			this.m.TargetTile = null;
		}

		return false;
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

