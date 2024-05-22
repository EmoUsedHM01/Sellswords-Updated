::mods_hookExactClass("skills/actives/slash", function(o) {
	o.m.isBunt <- false;

	local ws_onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			ws_onAnySkillUsed(_skill, _targetEntity, _properties)
			
			if (this.m.isBunt)
			{
				_properties.DamageTotalMult *= 0.8;
				//_properties.DamageDirectAdd += 0.05;				
			}						
		}
	}

})