this.ai_spawn_ghost_fragment <- ::inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
	},
	function create()
	{
		this.m.ID = 85;
		this.m.Order = 39;
		this.behavior.create();
	}

	function onEvaluate( _entity , _isForce = false , _defaultTile = null )
	{
		local score = this.getProperties().BehaviorMult[this.m.ID];
		this.m.TargetTile = null;

		if (!_isForce || _defaultTile == null)
			return ::Const.AI.Behavior.Score.Zero;

		local myTile = _entity.getTile();
		local destinations = [];
		local potentialDestinations = [];
		this.getStrategy().cleanUpKnownOpponents();
		this.getStrategy().compileKnownOpponents();
		local targets = this.getAgent().getKnownOpponents();
		local minRange = 1;
		local maxRange = targets.len() <= 7 ? 1 : 2;

		foreach( t in targets )
		{
			if (t.Actor.isNull())
				continue;

			local targetValue = this.queryTargetValue(_entity, t.Actor);

			if (t.Actor.getCurrentProperties().IsStunned)
				targetValue *= 1.5;

			local potentialTiles = this.queryDestinationsInRange(t.Actor.getTile(), minRange, maxRange);

			foreach( tile in potentialTiles )
			{
				if (!tile.IsEmpty || tile.Type == ::Const.Tactical.TerrainType.Impassable)
					continue;

				local score = 60.0 + 40.0 * targetValue;
				score = score - tile.getZoneOfOccupationCountOtherThan(_entity.getAlliedFactions()) * 30.0;
				score = score + tile.TVTotal;
				score = score - (tile.Properties.Effect != null && tile.Properties.Effect.Type != "miasma" && !tile.Properties.Effect.IsPositive ? 40.0 : 0.0);

				foreach( o in targets )
				{
					if (o.Actor.isNull() || o.Actor.getID() == t.Actor.getID())
						continue;

					if (o.Actor.getMoraleState() == ::Const.MoraleState.Fleeing || o.Actor.getCurrentProperties().IsStunned)
						continue;

					local d = o.Actor.getTile().getDistanceTo(tile);

					if (d <= 2)
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

					if (nextTile.IsOccupiedByActor && nextTile.getEntity().getFlags().has("ghost_boss"))
						score = score - 40.0;
				}
			}

			potentialDestinations.push({
				Tile = pd.Tile,
				Score = score
			});
		}

		if (potentialDestinations.len() == 0)
		{
			this.m.TargetTile = _defaultTile;
			return ::Const.AI.Behavior.Score.Zero;
		}

		potentialDestinations.sort(this.onSortByScore);
		this.m.TargetTile = potentialDestinations[0].Tile;
		return ::Const.AI.Behavior.Score.Zero;
	}

	function onExecute( _entity, _damageHitpoints = 0 )
	{
		if (this.m.TargetTile != null && _damageHitpoints > 0)
		{
			if (!this.m.TargetTile.IsEmpty)
			{
				::logInfo("Target tile is occupied, unable to spawn ghost fragment.");
				this.m.TargetTile = null;
				return false;
			}

			local num = _entity.getGhostFragmentNum();
			local fragment = ::Tactical.spawnEntity("scripts/entity/tactical/enemies/ghost_praetorian_boss_fragment", this.m.TargetTile.Coords);
			fragment.setFaction(_entity.getFaction());
			fragment.setName(_entity.getName() + "\'s Fragment");
			fragment.getFlags().set("return", this.getReturnCooldown(num));
			fragment.spawnGhostEffect(this.m.TargetTile);
			local b = fragment.m.BaseProperties;
			b.MeleeSkill = _entity.getBaseProperties().getMeleeSkill() - ::Math.rand(0, 5);
			b.MeleeDefense = _entity.getBaseProperties().getMeleeDefense() - ::Math.rand(0, 5);
			b.Hitpoints = _damageHitpoints;

			if (_entity.getHitpointsPct() <= 0.5)
			{
				b.DamageRegularMult += 0.1;
				b.DamageReceivedRegularMult *= 0.75;
			}

			if (_entity.getHitpoints() <= 1)
			{
				b.MeleeSkill += 5;
				b.MeleeDefense += 5;
				b.DamageRegularMult += 0.1;
				fragment.getSkills().add(::new("scripts/skills/perks/perk_nine_lives"));
			}

			fragment.getSkills().update();
			fragment.setHitpointsPct(1.0);
			this.m.TargetTile = null;
		}

		return false;
	}

	function getReturnCooldown( _fragmentNum = 1 )
	{
		local _num = ::Tactical.Entities.getAlliesNum();

		if (_fragmentNum <= ::Math.rand(1, _num))
			return ::Time.getRound() + 2;

		return ::Time.getRound() + 1;
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