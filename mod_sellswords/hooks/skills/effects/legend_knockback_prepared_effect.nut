::mods_hookExactClass("skills/effects/legend_knockback_prepared_effect", function (o)
{
	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		--this.m.AttacksLeft;
		_targetEntity.getSkills().getSkillByID("effects.legend_baffled");
		_targetEntity.getSkills().getSkillByID("effects.cr_smackdown");

		if (this.m.AttacksLeft <= 0)
			this.removeSelf();
	}

});