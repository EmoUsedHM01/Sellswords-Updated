this.kuangzhanshinuhou_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3
	},
	function create()
	{
		this.m.ID = "effects.kuangzhanshinuhou_effect";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "perk_35";
		this.m.IconMini = "perk_36_mini";
		this.m.Overlay = "perk_35";
		this.m.SoundOnUse = [
			"sounds/combat/rage_01.wav",
			"sounds/combat/rage_02.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	

	function onAdded()
	{
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("permanent_injury_4"))
		{
			local sprite = actor.getSprite("permanent_injury_4");
			sprite.Visible = true;
			sprite.setBrush("zombie_rage_eyes");
			sprite.Alpha = 0;
			sprite.fadeIn(1500);
		}

		actor.setDirty(true);
	}

	function onAfterUpdate( _properties )
	{
		if (this.m.TurnsLeft > 0)
		{
			_properties.MeleeSkill += 15;
			_properties.Initiative += 40;
			_properties.Bravery += 20;			
			_properties.MeleeDefense -= 15;
		}
	}

    function onRemoved()
	{
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("permanent_injury_4"))
		{
			actor.getSprite("permanent_injury_4").Visible = false;
			actor.removeSprite("permanent_injury_4");
		}


	}

	function onTurnEnd()
	{
		this.m.TurnsLeft = this.m.TurnsLeft - 1
		if (this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Actor, this.getContainer().getActor().getPos(), this.Math.rand(100, 115) * 0.01 * this.getContainer().getActor().getSoundPitch());
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Actor, this.getContainer().getActor().getPos(), this.Math.rand(100, 115) * 0.01 * this.getContainer().getActor().getSoundPitch());
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		actor.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = [
		    "sounds/combat/rage_01.wav",
			"sounds/combat/rage_02.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/combat/rage_01.wav",
			"sounds/combat/rage_02.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Death] = [
		   "sounds/combat/rage_01.wav",
			"sounds/combat/rage_02.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Fatigue] = [
		    "sounds/combat/rage_01.wav",
			"sounds/combat/rage_02.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
		    "sounds/combat/rage_01.wav",
			"sounds/combat/rage_02.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/combat/rage_01.wav",
			"sounds/combat/rage_02.wav"
		];
	}

});

