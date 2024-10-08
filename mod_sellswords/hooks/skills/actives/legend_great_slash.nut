::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_great_slash", function ( q ) {

	q.m.isBunt <- false;

	q.onAnySkillUsed = @( __original ) function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			__original(_skill, _targetEntity, _properties)
			
			if (this.m.isBunt)
			{
				_properties.DamageTotalMult *= 0.8;
				//_properties.DamageDirectAdd += 0.05;				
			}						
		}
	}

});
