::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/weapon", function ( q ) {
	q.onDamageDealt = @(__original) function( _target, _skill, _hitInfo )
	{
		local actor = this.getContainer().getActor();
		if (actor == null || actor.isNull())
		{
			return;
		}
		if (actor.isPlayerControlled() && _skill.getDirectDamage() < 1.0 && !_skill.isRanged() && this.m.ConditionMax > 1)
		{
			if (_target.getArmorMax(_hitInfo.BodyPart) >= 50 && _hitInfo.DamageInflictedArmor >= 5 || this.m.ConditionMax == 2)
			{
				this.lowerCondition();
			}
		}
	}
});	
