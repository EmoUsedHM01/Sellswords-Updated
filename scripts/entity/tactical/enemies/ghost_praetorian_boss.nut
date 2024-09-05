this.ghost_praetorian_boss <- ::inherit("scripts/entity/tactical/actor", {
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
		this.m.XP = 3000;
		this.actor.create();
		this.m.Name = "Kriegsgeist";
		this.m.Sound[::Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/ghost_death_01.wav",
			"sounds/enemies/ghost_death_02.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/geist_idle_01.wav",
			"sounds/enemies/geist_idle_02.wav",
			"sounds/enemies/geist_idle_03.wav",
			"sounds/enemies/geist_idle_04.wav",
			"sounds/enemies/geist_idle_05.wav",
			"sounds/enemies/geist_idle_06.wav",
			"sounds/enemies/geist_idle_07.wav",
			"sounds/enemies/geist_idle_08.wav",
			"sounds/enemies/geist_idle_09.wav",
			"sounds/enemies/geist_idle_10.wav",
			"sounds/enemies/geist_idle_11.wav",
			"sounds/enemies/geist_idle_12.wav",
			"sounds/enemies/geist_idle_13.wav",
			"sounds/enemies/geist_idle_14.wav",
			"sounds/enemies/geist_idle_15.wav",
			"sounds/enemies/geist_idle_16.wav",
			"sounds/enemies/geist_idle_17.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.DamageReceived] = this.m.Sound[::Const.Sound.ActorEvent.Death];
		this.m.SoundVolume[::Const.Sound.ActorEvent.DamageReceived] = 0.5;
		this.m.SoundPitch = 80 * 0.01;
		this.getFlags().add("ghost_boss");
		this.getFlags().add("undead");
		this.getFlags().add("ghost");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/ghost_praetorian_boss_agent");
		this.m.AIAgent.setActor(this);
	}

	function getGhostSprite()
	{
		return this.getSprite("body").getBrush().Name;
	}

	function getGhostFragmentNum()
	{
		local ret = 0;

		foreach (a in ::Tactical.Entities.getInstancesOfFaction(this.getFaction()))
		{
			if (a.getFlags().has("ghost_fragment")) ++ret;
		}

		return ret;
	}

	function canReturnFragment()
	{
		local time = ::Time.getRound();

		foreach (a in ::Tactical.Entities.getInstancesOfFaction(this.getFaction()))
		{
			if (a.getFlags().has("ghost_fragment") && a.getFlags().getAsInt("return") <= time)
			{
				return true;
			}
		}

		return false;
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null)
		{
			local effect = {
				Delay = 0,
				Quantity = 12,
				LifeTimeQuantity = 12,
				SpawnRate = 100,
				Brushes = [
					this.getGhostSprite()
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

		this.getItems().dropAll(_tile, _killer, false);
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
			local lv = _actor.getLevel();
			local corpse = _tile.Properties.get("Corpse");
			corpse.Faction = this.getFaction();
			corpse.Hitpoints = 1.0;
			corpse.Items = _actor.getItems();
			corpse.IsConsumable = false;
			corpse.IsResurrectable = false;

			if (_actor.getFlags().has("human"))
			{
				if (lv >= 21)
				{
					corpse.Type = "scripts/entity/tactical/enemies/zombie_betrayer";
				}
				else if (lv >= 11)
				{
					corpse.Type = "scripts/entity/tactical/enemies/zombie_knight";
				}
			}

			::Time.scheduleEvent(::TimeUnit.Rounds, ::Math.rand(1, 2), ::Tactical.Entities.resurrect, corpse);
		}
	}

	function onDamageReceived( _attacker, _skill, _hitInfo )
	{
		if (this.m.Hitpoints > 1) 
		{
			this.m.IsAbleToDie = false;
			local ret = this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
			this.m.IsAbleToDie = true;
			return ret;
		}

		this.m.IsAbleToDie = this.getGhostFragmentNum() == 0;

		if (!this.m.IsAbleToDie)
		{
			this.m.IsAbleToDie = true;
			::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(this) + " remains unharmed!");
			local b = this.getAIAgent().getBehavior(70);
			b.onEvaluate(this, true);
			b.onExecute(this);
			return 0;
		}
		
		local ret = this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
		this.m.IsAbleToDie = true;
		return ret;
	}

	function recalculateStatsBasedOnPlayerParty()
	{
		local players = [];
		players.extend(::Tactical.Entities.getInstancesOfFaction(::Const.Faction.Player));
		players.extend(::Tactical.Entities.getInstancesOfFaction(::Const.Faction.PlayerAnimals));
		local levels = 0;
		local hitpoints = 0;
		local meleeSkill = 65; // min
		local meleeDefense = 25; // min

		foreach ( a in players )
		{
			local p = a.getCurrentProperties();
			hitpoints += ::Math.floor(a.getHitpointsMax() / 3);
			levels += a.getLevel();

			if (meleeSkill < p.getMeleeSkill()) meleeSkill = p.getMeleeSkill();

			if (meleeDefense < p.getMeleeDefense()) meleeDefense = p.getMeleeDefense();
		}

		local average_level = ::Math.floor(levels / players.len());
		local b = this.m.BaseProperties;
		b.Hitpoints = ::Math.max(250, hitpoints + 50);
		b.MeleeSkill = meleeSkill;
		b.MeleeDefense = meleeDefense;
		b.Bravery += average_level * 5;

		if (average_level <= 6) b.DamageRegularMult *= 0.45;
		else if (average_level <= 13) b.DamageRegularMult *= 0.7;
		else if (average_level >= 20) b.DamageRegularMult *= 1.33;

		this.m.Skills.update();
		this.setHitpointsPct(1.0);
	}

	function onInit()
	{
		this.actor.onInit();
		this.setRenderCallbackEnabled(true);
		local b = this.m.BaseProperties;

		// minimum base stats
		b.ActionPoints = 10;
		b.Hitpoints = 250;
		b.Bravery = 90;
		b.Stamina = 150;
		b.MeleeSkill = 65;
		b.RangedSkill = 0;
		b.MeleeDefense = 25;
		b.RangedDefense = 999;
		b.Initiative = 125;
		b.FatigueEffectMult = 0.0;
		b.MoraleEffectMult = 0.0;

		// resistance
		b.IsImmuneToStun = true;
		//b.IsImmuneToDaze = true;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsImmuneToRoot = true;
		b.IsImmuneToDisarm = true;
		b.IsImmuneToFire = true;
		b.IsImmuneToRotation = true;
		b.IsImmuneToDamageReflection = true;
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

		local ghost_sprite = "bust_ghost_praetorian";
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

		this.m.Skills.add(::new("scripts/skills/actives/ghost_teleport_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/ghost_collect_fragment_skill"));
		this.m.Skills.add(::new("scripts/skills/racial/ghost_boss_stats_changer"));
		this.m.Skills.add(::new("scripts/skills/racial/ghost_knight_boss_racial"));
		this.m.Skills.add(::new("scripts/skills/racial/ghastly_touch_racial"));
		this.m.Skills.add(::new("scripts/skills/racial/ghost_racial"));

		// need to change perks
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_spear"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_crFurinkazan"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_battleheart"));
		
		if ("Assets" in ::World && ::World.Assets != null && ::World.Assets.getCombatDifficulty() == ::Const.Difficulty.Legendary)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_devastating_strikes"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_bloody_harvest"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_colossus"));
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

	function assignRandomEquipment()
	{
		this.m.Items.equip(::new("scripts/items/weapons/special/ssu_legendary_spear"));
	}

});