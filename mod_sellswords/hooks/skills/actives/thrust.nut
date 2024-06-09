::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/thrust", function( q ) {
	q.m.spontoon <- 0;

	q.isDuelistValid <- function()
	{
		return true;
	}

	q.onAnySkillUsed = @( __original ) function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			__original(_skill, _targetEntity, _properties);
			
			if (this.m.spontoon == 1)
			{
				_properties.DamageRegularMin += 20;
				_properties.DamageRegularMax += 20;
			}			
		}
	}
});
