::mods_hookExactClass("skills/effects/overwhelmed_effect", function ( o )
{
	o.onUpdate = function( _properties )
	{
		if (this.getContainer().hasSkill("perk.crresilient"))
		{
			_properties.MeleeSkillMult = this.Math.maxf(0.0, _properties.MeleeSkillMult - 0.075 * this.m.Count);
			_properties.RangedSkillMult = this.Math.maxf(0.0, _properties.RangedSkillMult - 0.075 * this.m.Count);
		}
		else
		{
			_properties.MeleeSkillMult = this.Math.maxf(0.0, _properties.MeleeSkillMult - 0.1 * this.m.Count);
			_properties.RangedSkillMult = this.Math.maxf(0.0, _properties.RangedSkillMult - 0.1 * this.m.Count);
		}			
	}	
});	