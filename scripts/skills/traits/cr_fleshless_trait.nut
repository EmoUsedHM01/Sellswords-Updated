this.cr_fleshless_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.cr_fleshless";
		this.m.Name = "Fleshless";
		this.m.Description = "All skin is rotted or torn away, only bones remain.";
		this.m.Icon = "ui/traits/fleshless_trait.png";
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "Has no flesh. Immune to Bleeding, poison and fresh injuries."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "Has no blood. 60% fewer hitpoints. Heals at 10% normal rate. Requires no food."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Has no lungs. Effected by fatigue at 10% normal rate. Resistance to piercing type attacks."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Has no brain. Gains experience at 85%% of normal rate, free upkeep."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Has no heart. Not affected by morale, or allies fleeing or dying."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has no eyes, Not affected by night."
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		actor.m.MoraleState = this.Const.MoraleState.Ignore;
		_properties.IsImmuneToBleeding = true;
		_properties.IsImmuneToPoison = true;
		_properties.IsAffectedByNight = false;
		_properties.IsAffectedByFleeingAllies = false;
		_properties.IsAffectedByDyingAllies = false;
		_properties.IsAffectedByFreshInjuries = false;
		_properties.MoraleEffectMult = 0.1;
		_properties.FatigueEffectMult = 0.1;
		_properties.HitpointsRecoveryRateMult = 0.1;
		_properties.MovementFatigueCostMult = 0.1;
		_properties.DailyWageMult *= 0;
		_properties.XPGainMult *= 0.85;
		_properties.DailyFood = 0;
		_properties.HitpointsMult *= 0.4;
	}

	function onApplyAppearance()
	{
		local actor = this.getContainer().getActor();
		local body = actor.getSprite("body");
		body.setBrush("bust_skeleton_body_0" + this.Math.rand(1, 2));
		body.Saturation = 0.8;
		body.varySaturation(0.2);
		body.varyColor(0.025, 0.025, 0.025);

		if (actor.getFlags().has("human"))
		{
			actor.getSprite("injury_body").setBrush("bust_skeleton_body_injured");
		}

		if (this.isKindOf(actor, "player"))
		{
			actor.improveMood = function ( _change, _text = "" )
			{
			};
			actor.worsenMood = function ( _change, _text = "" )
			{
			};
		}

		local head = actor.getSprite("head");
		head.setBrush("bust_skeleton_head");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		actor.m.MoraleState = this.Const.MoraleState.Ignore;
		actor.m.BloodType = this.Const.BloodType.Bones;
		actor.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = [
			"sounds/enemies/skeleton_idle_06.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/skeleton_hurt_01.wav",
			"sounds/enemies/skeleton_hurt_02.wav",
			"sounds/enemies/skeleton_hurt_03.wav",
			"sounds/enemies/skeleton_hurt_04.wav",
			"sounds/enemies/skeleton_hurt_06.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/skeleton_death_01.wav",
			"sounds/enemies/skeleton_death_02.wav",
			"sounds/enemies/skeleton_death_03.wav",
			"sounds/enemies/skeleton_death_04.wav",
			"sounds/enemies/skeleton_death_05.wav",
			"sounds/enemies/skeleton_death_06.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Fatigue] = [
			"sounds/enemies/skeleton_idle_06.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/skeleton_idle_06.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/skeleton_idle_01.wav",
			"sounds/enemies/skeleton_idle_02.wav",
			"sounds/enemies/skeleton_idle_03.wav",
			"sounds/enemies/skeleton_idle_04.wav",
			"sounds/enemies/skeleton_idle_05.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/skeleton_idle_06.wav"
		];
	}

});

