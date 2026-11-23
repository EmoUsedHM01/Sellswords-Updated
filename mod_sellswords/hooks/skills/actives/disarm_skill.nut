::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/disarm_skill", function ( q ) {

	q.onAnySkillUsed = @( __original ) function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local bonus = this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 0;

			if (_targetEntity != null && _targetEntity.getType() == this.Const.EntityType.OrcWarlord)
			{
				bonus -= 40;
			}

			_properties.MeleeSkill += this.addHitChanceBonus(bonus);
			_properties.DamageTotalMult = 0.0;
			_properties.HitChanceMult[this.Const.BodyPart.Head] = 0.0;
		}
	}

});
