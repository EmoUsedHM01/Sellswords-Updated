::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_knockback_prepared_effect", function ( q ) {

	q.onTargetHit = @(__original) function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		--this.m.AttacksLeft;
		if (this.m.AttacksLeft <= 0)
		{
			this.removeSelf();
		}

		if (!_targetEntity.isAlive())
		{
			return;
		}

		// refresh the effects
		_targetEntity.getSkills().removeByID("effects.legend_baffled");
		_targetEntity.getSkills().removeByID("effects.cr_smackdown");

		_targetEntity.getSkills().add(this.new("scripts/skills/effects/legend_baffled_effect"));
		_targetEntity.getSkills().add(this.new("scripts/skills/effects/cr_smackdown_effect"));
	}

});