::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_bullseye", function ( q ) {

	q.onUpdate = @( __original ) function ( _properties )
	{
		_properties.RangedAttackBlockedChanceMult *= 0.44;
	}

	q.onAnySkillUsed =  @() function(_skill, _targetEntity, _properties)
	{
		if (_skill.isAttack() && _targetEntity != null && _targetEntity.getID() != this.getContainer().getActor().getID() && _targetEntity.getFaction() == this.getContainer().getActor().getFaction())
		{
			_properties.MeleeSkillMult *= 0.5;
			_properties.RangedSkillMult *= 0.5;
		}
	}

});