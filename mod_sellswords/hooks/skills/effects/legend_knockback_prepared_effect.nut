::mods_hookExactClass("skills/effects/legend_knockback_prepared_effect", function ( o ) {

	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		--this.m.AttacksLeft;
		if (this.m.AttacksLeft <= 0)
			this.removeSelf();

		if (_skill != this)
			return;

		if (!_targetEntity.isAlive())
			return;

		_targetEntity.getSkills().getSkillByID("effects.legend_baffled");
		_targetEntity.getSkills().getSkillByID("effects.cr_smackdown");
	}

});