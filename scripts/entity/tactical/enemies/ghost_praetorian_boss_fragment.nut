this.ghost_praetorian_boss_fragment <- ::inherit("scripts/entity/tactical/actor", {
	m = {
		DistortTargetA = null,
		DistortTargetPrevA = ::createVec(0, 0),
		DistortAnimationStartTimeA = 0,
		DistortTargetB = null,
		DistortTargetPrevB = ::createVec(0, 0),
		DistortAnimationStartTimeB = 0,
		DistortTargetC = null,
		DistortTargetPrevC = ::createVec(0, 0),
		DistortAnimationStartTimeC = 0,
		DistortTargetD = null,
		DistortTargetPrevD = ::createVec(0, 0),
		DistortAnimationStartTimeD = 0
	},
	function create()
	{
		this.m.Type = ::Const.EntityType.ZombieBoss;
		this.m.BloodType = ::Const.BloodType.None;
		this.m.MoraleState = ::Const.MoraleState.Ignore;
		this.m.IsEmittingMovementSounds = false;
		this.m.IsActingImmediately = true;
		this.m.XP = 100;
		this.actor.create();
		this.m.Sound[::Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/horrific_scream_01.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/ghost_death_01.wav",
			"sounds/enemies/ghost_death_02.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/geist_idle_13.wav",
			"sounds/enemies/geist_idle_14.wav",
			"sounds/enemies/geist_idle_15.wav",
			"sounds/enemies/geist_idle_16.wav",
			"sounds/enemies/geist_idle_17.wav"
		];
		this.m.SoundVolume[::Const.Sound.ActorEvent.DamageReceived] = 0.5;
		this.m.SoundPitch = ::Math.rand(90, 110) * 0.01;
		this.getFlags().add("ghost_fragment");
		this.getFlags().add("undead");
		this.getFlags().add("ghost");
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/ghost_fragment_agent");
		this.m.AIAgent.setActor(this);
	}

	function spawnGhostEffect( _tile )
	{
		local effect = {
			Delay = 0,
			Quantity = 12,
			LifeTimeQuantity = 12,
			SpawnRate = 100,
			Brushes = [
				"bust_ghost_fog_02"
			],
			Stages = [
				{
					LifeTimeMin = 1.0,
					LifeTimeMax = 1.0,
					ColorMin = ::createColor("ffffff5f"),
					ColorMax = ::createColor("ffffff5f"),
					ScaleMin = 1.0,
					ScaleMax = 1.0,
					RotationMin = 0,
					RotationMax = 0,
					VelocityMin = 80,
					VelocityMax = 100,
					DirectionMin = ::createVec(-1.0, -1.0),
					DirectionMax = ::createVec(1.0, 1.0),
					SpawnOffsetMin = ::createVec(-10, -10),
					SpawnOffsetMax = ::createVec(10, 10),
					ForceMin = ::createVec(0, 0),
					ForceMax = ::createVec(0, 0)
				},
				{
					LifeTimeMin = 1.0,
					LifeTimeMax = 1.0,
					ColorMin = ::createColor("ffffff2f"),
					ColorMax = ::createColor("ffffff2f"),
					ScaleMin = 0.9,
					ScaleMax = 0.9,
					RotationMin = 0,
					RotationMax = 0,
					VelocityMin = 80,
					VelocityMax = 100,
					DirectionMin = ::createVec(-1.0, -1.0),
					DirectionMax = ::createVec(1.0, 1.0),
					ForceMin = ::createVec(0, 0),
					ForceMax = ::createVec(0, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = ::createColor("ffffff00"),
					ColorMax = ::createColor("ffffff00"),
					ScaleMin = 0.1,
					ScaleMax = 0.1,
					RotationMin = 0,
					RotationMax = 0,
					VelocityMin = 80,
					VelocityMax = 100,
					DirectionMin = ::createVec(-1.0, -1.0),
					DirectionMax = ::createVec(1.0, 1.0),
					ForceMin = ::createVec(0, 0),
					ForceMax = ::createVec(0, 0)
				}
			]
		};
		::Tactical.spawnParticleEffect(false, effect.Brushes, _tile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, ::createVec(0, 40));
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null)
		{
			this.spawnGhostEffect(_tile);
		}

		if (!this.isHiddenToPlayer())
		{
			::Tactical.spawnSpriteEffect("active_41", ::createColor("#ffffff"), this.getTile(), ::Const.Tactical.Settings.SkillOverlayOffsetX, ::Const.Tactical.Settings.SkillOverlayOffsetY, ::Const.Tactical.Settings.SkillOverlayScale, ::Const.Tactical.Settings.SkillOverlayScale, ::Const.Tactical.Settings.SkillOverlayStayDuration + 750, 0, ::Const.Tactical.Settings.SkillOverlayFadeDuration);
		}

		if (_fatalityType != ::Const.FatalityType.Suicide && _killer != null && _killer.getMoraleState() != ::Const.MoraleState.Ignore)
		{
			if (!_killer.isHiddenToPlayer())
			{
				::Tactical.EventLog.log("A Horrific Scream echoes in " + ::Const.UI.getColorizedEntityName(_killer) + "\'s head");
			}

			local num = ::Math.rand(2, 3);

			for (local i = 0; i < num; ++i)
			{
				_killer.checkMorale(-1, ::Math.rand(-15, 10), ::Const.MoraleCheckType.MentalAttack);
			}
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onActorKilled( _actor, _tile, _skill )
	{
		if (_tile == null)
		{
			return;
		}

		if (_tile.IsCorpseSpawned && _tile.Properties.get("Corpse").IsResurrectable)
		{
			local corpse = _tile.Properties.get("Corpse");
			corpse.Faction = this.getFaction();
			corpse.Hitpoints = 0.7;
			corpse.Items = _actor.getItems();
			corpse.IsConsumable = false;
			corpse.IsResurrectable = false;

			if (_actor.getFlags().has("human") && _actor.getLevel() >= 11)
			{
				corpse.Type = "scripts/entity/tactical/enemies/zombie_knight";
			}

			::Time.scheduleEvent(::TimeUnit.Rounds, 1, ::Tactical.Entities.resurrect, corpse);
		}
	}

	function onInit()
	{
		this.actor.onInit();
		this.setRenderCallbackEnabled(true);
		local b = this.m.BaseProperties;
		
		// minimum base stats
		b.ActionPoints = 10;
		b.Hitpoints = 50;
		b.Bravery = 90;
		b.Stamina = 100;
		b.MeleeSkill = 65;
		b.RangedSkill = 0;
		b.MeleeDefense = 25;
		b.RangedDefense = 999;
		b.Initiative = ::Math.rand(75, 150);
		b.FatigueEffectMult = 0.0;
		b.MoraleEffectMult = 0.0;
		
		b.IsImmuneToStun = true;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsImmuneToRoot = true;
		b.IsImmuneToDisarm = true;
		b.IsImmuneToFire = true;
		b.IsImmuneToRotation = true;
		b.IsImmuneToDamageReflection = true;
		b.IsIgnoringArmorOnAttack = true;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsAffectedByRain = false;
		b.IsResistantToPhysicalStatuses = true;
		b.IsResistantToMiasma = true;

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.SameMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.m.MaxTraversibleLevels = 4;

		local ghost_sprite = "bust_ghost_fragment_0" + ::Math.rand(1, 7);
		this.m.Items.getAppearance().Body = ghost_sprite;
		this.addSprite("socket").setBrush("bust_base_undead");
		this.addSprite("fog").setBrush("bust_ghost_fog_02");
		local body = this.addSprite("body");
		body.setBrush(ghost_sprite);
		body.varySaturation(0.25);
		body.varyColor(0.2, 0.2, 0.2);
		local head = this.addSprite("head");
		head.setBrush(ghost_sprite);
		head.varySaturation(0.25);
		head.varyColor(0.2, 0.2, 0.2);
		local blur_1 = this.addSprite("blur_1");
		blur_1.setBrush(ghost_sprite);
		blur_1.varySaturation(0.25);
		blur_1.varyColor(0.2, 0.2, 0.2);
		local blur_2 = this.addSprite("blur_2");
		blur_2.setBrush(ghost_sprite);
		blur_2.varySaturation(0.25);
		blur_2.varyColor(0.2, 0.2, 0.2);
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.setSpriteOffset("status_rooted", ::createVec(-5, -5));

		this.m.Skills.add(::new("scripts/skills/racial/ghastly_touch_racial"));
		this.m.Skills.add(::new("scripts/skills/racial/ghost_racial"));
		local ghastly_touch = ::new("scripts/skills/actives/ghastly_touch");
		ghastly_touch.m.MaxRange = 2;
		this.m.Skills.add(ghastly_touch);

		this.m.Skills.add(::new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_double_strike"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_underdog"));

		if ("Assets" in ::World && ::World.Assets != null && ::World.Assets.getCombatDifficulty() == ::Const.Difficulty.Legendary)
		{
			b.DamageRegularMin += 5;
			b.DamageRegularMax += 10;
			this.m.Skills.add(::new("scripts/skills/perks/perk_feint"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
		}
	}

	function onRender()
	{
		this.actor.onRender();

		if (this.m.DistortTargetA == null)
		{
			this.m.DistortTargetA = ::createVec(::Math.rand(0, 8) - 4, ::Math.rand(0, 8) - 4);
			this.m.DistortAnimationStartTimeA = ::Time.getVirtualTimeF();
		}

		if (this.moveSpriteOffset("head", this.m.DistortTargetPrevA, this.m.DistortTargetA, 3.8, this.m.DistortAnimationStartTimeA))
		{
			this.m.DistortAnimationStartTimeA = ::Time.getVirtualTimeF();
			this.m.DistortTargetPrevA = this.m.DistortTargetA;
			this.m.DistortTargetA = ::createVec(::Math.rand(0, 8) - 4, ::Math.rand(0, 8) - 4);
		}

		if (this.m.DistortTargetB == null)
		{
			this.m.DistortTargetB = ::createVec(::Math.rand(0, 8) - 4, ::Math.rand(0, 8) - 4);
			this.m.DistortAnimationStartTimeB = ::Time.getVirtualTimeF();
		}

		if (this.moveSpriteOffset("blur_1", this.m.DistortTargetPrevB, this.m.DistortTargetB, 4.9000001, this.m.DistortAnimationStartTimeB))
		{
			this.m.DistortAnimationStartTimeB = ::Time.getVirtualTimeF();
			this.m.DistortTargetPrevB = this.m.DistortTargetB;
			this.m.DistortTargetB = ::createVec(::Math.rand(0, 8) - 4, ::Math.rand(0, 8) - 4);
		}

		if (this.m.DistortTargetC == null)
		{
			this.m.DistortTargetC = ::createVec(::Math.rand(0, 8) - 4, ::Math.rand(0, 8) - 4);
			this.m.DistortAnimationStartTimeC = ::Time.getVirtualTimeF();
		}

		if (this.moveSpriteOffset("body", this.m.DistortTargetPrevC, this.m.DistortTargetC, 4.3, this.m.DistortAnimationStartTimeC))
		{
			this.m.DistortAnimationStartTimeC = ::Time.getVirtualTimeF();
			this.m.DistortTargetPrevC = this.m.DistortTargetC;
			this.m.DistortTargetC = ::createVec(::Math.rand(0, 8) - 4, ::Math.rand(0, 8) - 4);
		}

		if (this.m.DistortTargetD == null)
		{
			this.m.DistortTargetD = ::createVec(::Math.rand(0, 8) - 4, ::Math.rand(0, 8) - 4);
			this.m.DistortAnimationStartTimeD = ::Time.getVirtualTimeF();
		}

		if (this.moveSpriteOffset("blur_2", this.m.DistortTargetPrevD, this.m.DistortTargetD, 5.5999999, this.m.DistortAnimationStartTimeD))
		{
			this.m.DistortAnimationStartTimeD = ::Time.getVirtualTimeF();
			this.m.DistortTargetPrevD = this.m.DistortTargetD;
			this.m.DistortTargetD = ::createVec(::Math.rand(0, 8) - 4, ::Math.rand(0, 8) - 4);
		}
	}

});