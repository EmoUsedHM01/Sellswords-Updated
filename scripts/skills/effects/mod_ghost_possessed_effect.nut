this.mod_ghost_possessed_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1,
		OriginalFaction = 0,
		OriginalAgent = null,
		OriginalSocket = null,
		PossessorFaction = 0,
		Possessor = null,
		IsActivated = false,
		IsBattleEnd = false,
		IsEnhanced = false,
		IsExorcised = false,
		AttackerID = null,
		GhostSkills = [],
		LastTile = null
	},
	function setPossessorFaction( _f )
	{
		this.m.PossessorFaction = _f;
	}

	function setExorcised( _f )
	{
		this.m.IsExorcised = _f;
	}

	function setPossessor( _f )
	{
		this.m.Possessor = _f;
	}

	function setEffect( _f )
	{
		this.m.IsEnhanced = _f;
	}

	function getName()
	{
		if (this.m.Possessor != null)
			return this.m.Name + " by " + this.Const.UI.getColorizedEntityName(this.m.Possessor);

		return this.skill.getName();
	}

	function create()
	{
		this.m.ID = "effects.ghost_possessed";
		this.m.Name = "Possessed";
		this.m.Icon = "skills/status_effect_69.png";
		this.m.IconMini = "status_effect_69_mini";
		this.m.Overlay = "";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function isHidden()
	{
		return !this.m.IsActivated;
	}

	function getDescription()
	{
		return "This character has been possessed, and no longer has any control over their actions and is a puppet that has no choice but to obey a master. Wears off in [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] turn(s).";
	}

	function addTurns( _t )
	{
		this.m.TurnsLeft += _t;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		this.m.OriginalFaction = actor.getFaction();
		this.m.OriginalSocket = actor.getSprite("socket").getBrush().Name;
		this.m.Overlay = "status_effect_69";
		actor.getFlags().set("Charmed", true);
	}

	function onRemoved()
	{
		if (!this.m.IsBattleEnd)
		{
			local tile = this.findTileToSpawnGhost();

			if (tile == null)
				tile = this.findTileToSpawnGhost(this.m.LastTile);

			if (tile != null && !this.Tactical.Entities.isCombatFinished())
			{
				local info = {
					Tile = tile,
					Self = this
				};

				this.onSpawnGhost(info);
			}
		}

		foreach ( skill in this.m.GhostSkills )
			skill.removeSelf();

		local actor = this.getContainer().getActor();
		actor.getSprite("status_hex").Visible = false;
		actor.getSprite("status_sweat").Visible = false;

		if (this.m.OriginalAgent != null)
			actor.setAIAgent(this.m.OriginalAgent);

		actor.setMoraleState(this.Math.rand(1, 100) <= 33 ? this.Const.MoraleState.Fleeing : this.Const.MoraleState.Breaking);
		actor.setFaction(this.m.OriginalFaction);
		actor.getSprite("socket").setBrush(this.m.OriginalSocket);
		actor.getFlags().set("Charmed", false);
		actor.setDirty(true);
	}

	function onSpawnGhost( _info )
	{
		local _tile = _info.Tile;
		local _skill = _info.Self;
		_skill.spawnGhostEffect(_tile);
		this.Tactical.addEntityToMap(this.m.Possessor, _tile.Coords.X, _tile.Coords.Y);

		if (!_skill.m.Possessor.getType() != this.Const.EntityType.Player && _skill.m.Possessor.getType() != this.Const.EntityType.Serpent)
			this.Tactical.getTemporaryRoster().remove(_skill.m.Possessor);

		this.Tactical.TurnSequenceBar.addEntity(_skill.m.Possessor);

		if (_skill.m.IsExorcised)
		{
			local attacker = _skill.m.Possessor;

			if (_skill.m.AttackerID != null)
			{
				local e = this.Tactical.getEntityByID(_skill.m.AttackerID);

				if (e != null)
					attacker = e;
			}

			this.Time.scheduleEvent(this.TimeUnit.Virtual, 100, function ( _e )
			{
				local poison = _skill.m.Possessor.getSkills().getSkillByID("effects.holy_water");

				if (poison == null)
					_skill.m.Possessor.getSkills().add(this.new("scripts/skills/effects/holy_water_effect"));
				else
					poison.resetTime();

			}.bindenv(_skill), _skill);
		}
	}

	function onPossess()
	{
		local actor = this.getContainer().getActor();
		local isHuman = actor.getFlags().has("human");

		if (actor.isPlayerControlled())
		{
			this.m.OriginalAgent = actor.getAIAgent();
			actor.setAIAgent(this.new("scripts/ai/tactical/agents/charmed_player_agent"));
			actor.getAIAgent().setActor(actor);
		}

		actor.setFaction(this.m.PossessorFaction);
		actor.getSprite("socket").setBrush(this.m.Possessor.getSprite("socket").getBrush().Name);

		local sprite = actor.getSprite("status_hex");
		sprite.setBrush("ghost_mind_control");
		sprite.Visible = true;
		
		if (actor.isHiddenToPlayer())
			sprite.Alpha = 255;
		else
		{
			sprite.Alpha = 0;
			sprite.fadeIn(1500);
		}

		if (isHuman)
		{
			local sweat = actor.getSprite("status_sweat");
			sweat.setBrush("ghost_possess_eyes");
			sweat.Visible = true;

			if (actor.isHiddenToPlayer())
				sweat.Alpha = 255;
			else
			{
				sweat.Alpha = 0;
				sweat.fadeIn(1500);
			}
		}

		local AI = actor.getAIAgent();
		AI.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_ghost_possess"));
		AI.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_terror"));
		local touch = this.new("scripts/skills/actives/ghastly_touch");
		touch.m.IsRemovedAfterBattle = true;
		this.getContainer().add(touch);
		this.m.GhostSkills.push(touch);
		local scream = this.m.Possessor.getType() == this.Const.EntityType.LegendBanshee ? this.new("scripts/skills/actives/legend_banshee_scream") : this.new("scripts/skills/actives/horrific_scream");
		scream.m.IsRemovedAfterBattle = true;
		this.getContainer().add(scream);
		this.m.GhostSkills.push(scream);
		actor.checkMorale(10, 9000);
		actor.setDirty(true);
		this.m.IsActivated = true;
		this.m.TurnsLeft = this.m.IsEnhanced ? 5 : 3;
		this.spawnIcon(this.m.Overlay, actor.getTile());
	}

	function onTurnEnd()
	{
		local actor = this.getContainer().getActor();

		if (--this.m.TurnsLeft <= 0)
		{
			if (!this.m.IsActivated)
				this.onPossess();
			else
				this.removeSelf();
		}
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();

		if (myTile.Properties.Effect != null && myTile.Properties.Effect.Type == "legend_holyflame")
		{
			this.setExorcised(true);
			this.removeSelf();
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.m.Possessor) + " has been banished out of " + this.Const.UI.getColorizedEntityName(actor) + "\'s body");
			return;
		}
		else if (this.m.IsActivated && actor.getCurrentProperties().IsStunned)
		{
			this.removeSelf();
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.m.Possessor) + " has been banished out of " + this.Const.UI.getColorizedEntityName(actor) + "\'s body");
			return;
		}

		if (!this.m.IsActivated && actor.getMoraleState() == this.Const.MoraleState.Fleeing)
			actor.setActionPoints(0);
	}

	function findTileToSpawnGhost( _tile = null )
	{
		if (_tile == null)
			_tile = this.getContainer().getActor().getTile();

		this.Sound.play("sounds/enemies/horrific_scream_01.wav", this.Const.Sound.Volume.Skill * 1.2, _tile.Pos);

		local result = {
			TargetTile = _tile,
			Destinations = []
		};
		this.Tactical.queryTilesInRange(_tile, 2, 5, false, [], this.onQueryTiles, result);

		if (result.Destinations.len() == 0)
			return null;

		return result.Destinations[this.Math.rand(0, result.Destinations.len() - 1)];
	}

	function onQueryTiles( _tile, _tag )
	{
		if (!_tile.IsEmpty)
			return;

		_tag.Destinations.push(_tile);
	}

	function onCombatFinished()
	{
		this.m.IsBattleEnd = true;

		if (this.Tactical.Entities.getInstancesNum(this.Const.Faction.Player) == 0)
			this.getContainer().getActor().kill(null, null, this.Const.FatalityType.Suicide);

		this.skill.onCombatFinished();
	}

	function onMovementCompleted( _tile )
	{
		this.m.LastTile = _tile;

		local actor = this.getContainer().getActor();

		if (_tile.Properties.Effect != null && _tile.Properties.Effect.Type == "legend_holyflame")
		{
			this.setExorcised(true);
			this.removeSelf();
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.m.Possessor) + " has been banished out of " + this.Const.UI.getColorizedEntityName(actor) + "\'s body");
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (this.m.IsActivated && _damageHitpoints >= this.Const.Combat.InjuryMinDamage && this.Math.rand(1, 100) <= 25)
		{
			this.removeSelf();
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.m.Possessor) + " has been banished out of " + this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + "\'s body");
		}
	}

	function onUpdate( _properties )
	{
		_properties.IsAffectedByDyingAllies = false;
		_properties.IsAffectedByLosingHitpoints = false;

		if (this.m.IsActivated)
		{
			_properties.Initiative += 25;
			_properties.Bravery += 50;
			_properties.MeleeSkill += 10;
			_properties.RangedSkill += 10;
			_properties.MeleeDefense += 10;
			_properties.RangedDefense += 10;
			_properties.DamageReceivedTotalMult *= 0.75;
		}
		else
		{
			_properties.TargetAttractionMult *= 0.25;
			_properties.MoraleCheckBravery[this.Const.MoraleCheckType.MentalAttack] += 25;
			_properties.MeleeSkill -= 10;
			_properties.RangedSkill -= 10;
			_properties.MeleeDefense += 10;
			_properties.RangedDefense += 10;
		}
	}

	function onOtherActorDeath( _killer, _victim, _skill, _deathTile, _corpseTile, _fatalityType )
	{
		if (!this.m.IsActivated)
			if (this.Tactical.Entities.getHostilesNum() <= 2)
				this.onPossess();
		else
			this.m.TurnsLeft = this.Tactical.Entities.getHostilesNum() <= 1 ? 99 : this.m.TurnsLeft;
	}

	function onDeath()
	{
		this.onRemoved();
	}

	function spawnGhostEffect( _tile )
	{
		local effect = {
			Delay = 0,
			Quantity = 12,
			LifeTimeQuantity = 12,
			SpawnRate = 100,
			Brushes = [
				"bust_ghost_01"
			],
			Stages = [
				{
					LifeTimeMin = 1.0,
					LifeTimeMax = 1.0,
					ColorMin = this.createColor("ffffff5f"),
					ColorMax = this.createColor("ffffff5f"),
					ScaleMin = 1.0,
					ScaleMax = 1.0,
					RotationMin = 0,
					RotationMax = 0,
					VelocityMin = 80,
					VelocityMax = 100,
					DirectionMin = this.createVec(-1.0, -1.0),
					DirectionMax = this.createVec(1.0, 1.0),
					SpawnOffsetMin = this.createVec(-10, -10),
					SpawnOffsetMax = this.createVec(10, 10),
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 1.0,
					LifeTimeMax = 1.0,
					ColorMin = this.createColor("ffffff2f"),
					ColorMax = this.createColor("ffffff2f"),
					ScaleMin = 0.9,
					ScaleMax = 0.9,
					RotationMin = 0,
					RotationMax = 0,
					VelocityMin = 80,
					VelocityMax = 100,
					DirectionMin = this.createVec(-1.0, -1.0),
					DirectionMax = this.createVec(1.0, 1.0),
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.1,
					ScaleMax = 0.1,
					RotationMin = 0,
					RotationMax = 0,
					VelocityMin = 80,
					VelocityMax = 100,
					DirectionMin = this.createVec(-1.0, -1.0),
					DirectionMax = this.createVec(1.0, 1.0),
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		};
		this.Tactical.spawnParticleEffect(false, effect.Brushes, _tile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 40));
	}

});

