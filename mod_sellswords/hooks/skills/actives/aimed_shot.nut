::mods_hookExactClass("skills/actives/aimed_shot", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.FatigueCost = 20;
		this.m.ActionPointCost = 6;
	}
	
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
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