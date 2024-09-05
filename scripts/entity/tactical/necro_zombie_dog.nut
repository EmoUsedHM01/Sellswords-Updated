this.necro_zombie_dog <- this.inherit("scripts/entity/tactical/wardog", {
	m = {
		Name = "Raised Hound"
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.Wardog;
		this.m.BloodType = this.Const.BloodType.Dark;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = this.Const.Tactical.Actor.NecroZombieDog.XP;
		this.m.IsActingImmediately = true;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(-4, -25);
		this.m.DecapitateBloodAmount = 0.5;
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/wardog_hurt_00.wav",
			"sounds/enemies/wardog_hurt_01.wav",
			"sounds/enemies/wardog_hurt_02.wav",
			"sounds/enemies/wardog_hurt_03.wav",
			"sounds/enemies/wardog_hurt_04.wav",
			"sounds/enemies/wardog_hurt_05.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/wardog_death_00.wav",
			"sounds/enemies/wardog_death_01.wav",
			"sounds/enemies/wardog_death_02.wav",
			"sounds/enemies/wardog_death_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/wardog_flee_00.wav",
			"sounds/enemies/wardog_flee_01.wav",
			"sounds/enemies/wardog_flee_02.wav",
			"sounds/enemies/wardog_flee_03.wav",
			"sounds/enemies/wardog_flee_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/wardog_idle_01.wav",
			"sounds/enemies/wardog_idle_02.wav",
			"sounds/enemies/wardog_idle_03.wav",
			"sounds/enemies/wardog_idle_04.wav",
			"sounds/enemies/wardog_idle_05.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/wardog_charge_00.wav",
			"sounds/enemies/wardog_charge_01.wav",
			"sounds/enemies/wardog_charge_02.wav"
		];
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Move] = 0.1;
		this.m.SoundPitch = this.Math.rand(70, 120) * 0.01;
		this.getFlags().add("undead");
		this.getFlags().add("zombie");
		this.getFlags().add("zombie_minion");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/wardog_agent");
		this.m.AIAgent.setActor(this);
	}
	
	function playSound( _type, _volume, _pitch = 1.0 )
	{
		if (_type == this.Const.Sound.ActorEvent.Move && this.Math.rand(1, 100) <= 50)
			return;

		this.actor.playSound(_type, _volume, _pitch);
	}
	
	function setVariant( _v )
	{
		this.m.Items.getAppearance().Body = "bust_zombie_dog_body_0" + _v;
		this.getSprite("body").setBrush("bust_zombie_dog_body_0" + _v);
		this.getSprite("head").setBrush("bust_zombie_dog_head_0" + _v);
		this.setDirty(true);
	}
	
	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.NecroZombieDog);
		b.TargetAttractionMult = 0.1;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		local variant = 1;
		this.m.Items.getAppearance().Body = "bust_zombie_dog_body_0" + variant;
		this.addSprite("socket").setBrush("bust_base_undead");
		
		local body = this.addSprite("body");
		body.setHorizontalFlipping(false);
		body.setBrush("bust_zombie_dog_body_0" + variant);
		
		local armor = this.addSprite("armor");
		armor.setHorizontalFlipping(false);
		
		local head = this.addSprite("head");
		head.setHorizontalFlipping(false);
		head.setBrush("bust_zombie_dog_head_0" + variant);
		
		local closed_eyes = this.addSprite("closed_eyes");
		closed_eyes.Visible = false;
		
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_zombie_dog_body_01_injured");
		
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.46;
		this.setSpriteOffset("status_rooted", this.createVec(8, -15));
		this.setSpriteOffset("status_stunned", this.createVec(0, -25));
		this.setSpriteOffset("arrow", this.createVec(0, -25));
		this.m.Skills.add(this.new("scripts/skills/actives/wardog_bite"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_last_stand"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.BaseProperties.Hitpoints *= 1.5;
			this.m.Hitpoints *= 1.5;
		}

		this.m.Skills.update();
	}

});