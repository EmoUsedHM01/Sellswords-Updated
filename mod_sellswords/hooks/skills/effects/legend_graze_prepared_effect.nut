::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_graze_prepared_effect", function ( q ) {

	q.onTargetHit = @(__original) function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		--this.m.AttacksLeft;

		if (this.m.AttacksLeft <= 0)
			this.removeSelf();

		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding || _damageInflictedHitpoints <= this.Const.Combat.MinDamageToApplyBleeding || _targetEntity.getHitpoints() <= 0)
			return;

		if (!_targetEntity.isAlive())
			return;

		if (!_targetEntity.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is bleeding from grazes");
		}

		local bleed = this.new("scripts/skills/effects/bleeding_effect");
		bleed.setDamage(2);
		bleed.m.bleed_type = 5;
		_targetEntity.getSkills().add(bleed);
		local skill = _targetEntity.getSkills().getSkillByID("effects.bleeding");
	}

});