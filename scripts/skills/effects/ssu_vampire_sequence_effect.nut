this.ssu_vampire_sequence_effect <- this.inherit("scripts/skills/effects/ssu_sequence_effect", {
	m = {
		ShouldHeal = false
	},
	function create()
	{
		this.ssu_sequence_effect.create();
		this.setSequence("vampire");
		this.m.Icon = "skills/status_effect_133.png";
		this.m.Overlay = "status_effect_133";
		this.m.SoundOnUse = [
			"sounds/enemies/vampire_life_drain_01.wav",
			"sounds/enemies/vampire_life_drain_02.wav",
			"sounds/enemies/vampire_life_drain_03.wav"
		];
	}

	function onStrainAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("IsRejuvinated", true);
		actor.getSkills().removeByID("trait.old");
		::Mod_Sellswords.addSequencePerk(actor, ::Legends.Perk.NineLives, 0);

		if (this.isStrong())
			::Mod_Sellswords.addSequencePerk(actor, ::Legends.Perk.LegendDarkflight, 6);
	}

	// the Lord Strain also keeps morale from falling below Steady, which is done in the player hook
	function onUpdate( _properties )
	{
		_properties.MeleeSkill += this.isStrong() ? 15 : 5;
		_properties.Hitpoints += this.isStrong() ? 30 : 10;

		if (this.isStrong())
		{
			_properties.Bravery += 10;
			_properties.IsImmuneToPoison = true;
		}
	}

	function onCombatStarted()
	{
		this.m.ShouldHeal = false;
	}

	function onCombatFinished()
	{
		this.m.ShouldHeal = false;
	}

	// Parasitic Blood
	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_damageInflictedHitpoints <= 0)
			return;

		// a killing blow, noted by onTargetKilled
		if (this.m.ShouldHeal)
		{
			this.m.ShouldHeal = false;
			this.lifesteal(_damageInflictedHitpoints);
			return;
		}

		if (_targetEntity == null || !_targetEntity.isAlive() || _targetEntity.getCurrentProperties().IsImmuneToBleeding)
			return;

		if (this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			this.lifesteal(_damageInflictedHitpoints);
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding)
			return;

		if (this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			this.m.ShouldHeal = true;
	}

	function lifesteal( _damageInflictedHitpoints )
	{
		local actor = this.getContainer().getActor();
		local healed = this.Math.round(_damageInflictedHitpoints * (this.isStrong() ? 0.25 : 0.15));
		healed = this.Math.min(actor.getHitpointsMax() - actor.getHitpoints(), healed);

		if (healed <= 0)
			return;

		actor.setHitpoints(actor.getHitpoints() + healed);
		actor.onUpdateInjuryLayer();
		this.spawnIcon("status_effect_09", actor.getTile());

		if (!actor.isHiddenToPlayer())
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect, actor.getPos());
			this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_sequence_effect.LogHealed, this.Const.UI.getColorizedEntityName(actor), healed));
		}
	}

});
