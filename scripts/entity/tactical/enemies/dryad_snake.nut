this.dryad_snake <- this.inherit("scripts/entity/tactical/dryad_summon_actor", {
	m = {
		Variant = 1,
		BonusArmor = -20,
		Name = "Thicket Stalker"
	},

	function create()
	{
		this.m.Type = this.Const.EntityType.Schrat;
		this.m.BloodType = this.Const.BloodType.Wood;
		this.m.IsActingImmediately = true;
		this.m.XP = this.Const.Tactical.Actor.Serpent.XP;
		this.m.BloodSplatterOffset = this.createVec(0, 5);
		this.m.DecapitateSplatterOffset = this.createVec(15, -26);
		this.m.DecapitateBloodAmount = 1.0;
		this.m.ExcludedInjuries = [
			"injury.fractured_hand",
			"injury.crushed_finger",
			"injury.fractured_elbow",
			"injury.sprained_ankle",
			"injury.bruised_leg",
			"injury.smashed_hand",
			"injury.broken_arm",
			"injury.broken_leg",
			"injury.cut_arm_sinew",
			"injury.cut_arm",
			"injury.cut_achilles_tendon",
			"injury.split_hand",
			"injury.injured_shoulder",
			"injury.pierced_hand",
			"injury.pierced_arm_muscles",
			"injury.injured_knee_cap",
			"injury.burnt_legs",
			"injury.burnt_hands"
		];
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/dlc6/snake_hurt_01.wav",
			"sounds/enemies/dlc6/snake_hurt_02.wav",
			"sounds/enemies/dlc6/snake_hurt_03.wav",
			"sounds/enemies/dlc6/snake_hurt_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/dlc6/snake_death_01.wav",
			"sounds/enemies/dlc6/snake_death_02.wav",
			"sounds/enemies/dlc6/snake_death_03.wav",
			"sounds/enemies/dlc6/snake_death_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/dlc6/snake_idle_01.wav",
			"sounds/enemies/dlc6/snake_idle_02.wav",
			"sounds/enemies/dlc6/snake_idle_03.wav",
			"sounds/enemies/dlc6/snake_idle_04.wav",
			"sounds/enemies/dlc6/snake_idle_05.wav",
			"sounds/enemies/dlc6/snake_idle_06.wav",
			"sounds/enemies/dlc6/snake_idle_07.wav",
			"sounds/enemies/dlc6/snake_idle_08.wav",
			"sounds/enemies/dlc6/snake_idle_09.wav",
			"sounds/enemies/dlc6/snake_idle_10.wav",
			"sounds/enemies/dlc6/snake_idle_11.wav",
			"sounds/enemies/dlc6/snake_idle_12.wav",
			"sounds/enemies/dlc6/snake_idle_13.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = this.m.Sound[this.Const.Sound.ActorEvent.Idle];
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Move] = 0.7;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] = 2.0;
		this.m.SoundPitch = this.Math.rand(95, 105) * 0.01;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/serpent_agent");
		this.m.AIAgent.setActor(this);
	}
	
	function playAttackSound()
	{
		if (this.Math.rand(1, 100) <= 50)
		{
			this.playSound(this.Const.Sound.ActorEvent.Attack, this.Const.Sound.Volume.Actor * this.m.SoundVolume[this.Const.Sound.ActorEvent.Attack] * (this.Math.rand(75, 100) * 0.01), this.m.SoundPitch * 1.15);
		}
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
					"bust_druid_snake"
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
		
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}
	
	function setName(_n)
	{
		this.m.Name = _n;
	}

	function getName()
	{
		return this.m.Name;
	}

	function onActorKilled( _actor, _tile, _skill )
	{
		this.actor.onActorKilled(_actor, _tile, _skill);

		if (this.getFaction() == this.Const.Faction.Player || this.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			local XPgroup = _actor.getXPValue();
			local brothers = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);

			foreach( bro in brothers )
			{
				bro.addXP(this.Math.max(1, this.Math.floor(XPgroup / brothers.len())));
			}
		}
	}

	function onInit()
	{
		// Stat values, taking into account for bro scaling from the below function
		this.actor.onInit();
		local clouds = this.Tactical.getWeather().createCloudSettings();
		clouds.Type = this.getconsttable().CloudType.Fog;
		clouds.MinClouds = 20;
		clouds.MaxClouds = 20;
		clouds.MinVelocity = 3.0;
		clouds.MaxVelocity = 9.0;
		clouds.MinAlpha = 0.35;
		clouds.MaxAlpha = 0.45;
		clouds.MinScale = 2.0;
		clouds.MaxScale = 3.0;
		this.Tactical.getWeather().buildCloudCover(clouds);
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Serpent);
		b.Initiative += this.Math.rand(0, 50);
		b.Armor[0] += this.m.BonusArmor;
		b.ArmorMax[0] += this.m.BonusArmor;
		b.Armor[1] += this.m.BonusArmor;
		b.ArmorMax[1] += this.m.BonusArmor;
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		b.IsImmuneToBleeding = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		
		// "ghost" sprite, makes it a lot easier to hodge podge it
		local variant = 2;
		this.addSprite("socket").setBrush("bust_base_dryad");
		local legs_back = this.addSprite("legs_back");
		legs_back.setBrush("");
		local body = this.addSprite("body");
		body.setBrush("");
		local legs_front = this.addSprite("legs_front");
		legs_front.setBrush("");
		legs_front.Color = body.Color;
		legs_front.Saturation = body.Saturation;
		legs_back.Color = body.Color;
		legs_back.Saturation = body.Saturation;
		local head = this.addSprite("head");
		head.setBrush("bust_druid_snake");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("");
		local body_blood = this.addSprite("body_blood");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.54;
		this.setSpriteOffset("status_rooted", this.createVec(-10, 20));
		this.setSpriteOffset("status_stunned", this.createVec(-35, 20));
		this.setSpriteOffset("arrow", this.createVec(0, 20));
		
		this.m.Skills.add(this.new("scripts/skills/racial/serpent_racial"));
		this.m.Skills.add(this.new("scripts/skills/racial/dryad_racial"));
		
		this.m.Skills.add(this.new("scripts/skills/traits/loyal_trait"));
		
		this.m.Skills.add(this.new("scripts/skills/actives/serpent_hook_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/serpent_bite_skill"));
		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
		}

		if (::Is_MC_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nggh_serpent_bite"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nggh_serpent_drag"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nggh_serpent_giant"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nggh_serpent_venom"));
		}
	}

});