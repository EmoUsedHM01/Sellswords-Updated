::mods_hookExactClass("skills/actives/thrust", function(o) {
	o.m.spontoon <- 0;

	o.isDuelistValid <- function()
	{
		return true;
	}

	local ws_onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			ws_onAnySkillUsed(_skill, _targetEntity, _properties);
			
			if (this.m.spontoon == 1)
			{
				_properties.DamageRegularMin += 20;
				_properties.DamageRegularMax += 20;
			}			
		}
	}
});	