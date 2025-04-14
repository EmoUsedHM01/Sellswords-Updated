::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/throw_spear_skill", function( q ) {

	q.onAnySkillUsed = @( __original ) function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local weapon = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
			if (_targetEntity != null && _targetEntity.getCurrentProperties().IsSpecializedInShields && this.getContainer().getActor().getCurrentProperties().IsSpecializedInThrowing)
				weapon.m.ShieldDamage *= 2;

			if (this.getContainer().hasSkill("perk.legend_smashing_shields"))
				weapon.m.ShieldDamage *= 2;
			__original(_skill, _targetEntity, _properties);
		}
	}
});
