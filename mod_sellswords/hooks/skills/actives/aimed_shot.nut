::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/aimed_shot", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.FatigueCost = 20;
		this.m.ActionPointCost = 6;
	}
	
	q.onAnySkillUsed = @( __original) function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;

			if (this.getContainer().hasSkill("perk.ptr_target_practice"))
			{
				_properties.DamageRegularMult *= 1.15;
			}
			else
			{
				_properties.DamageRegularMult *= 1.1;
			}
		}
	};
});
