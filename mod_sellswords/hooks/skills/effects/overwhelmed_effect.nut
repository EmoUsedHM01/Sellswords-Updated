::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/overwhelmed_effect", function ( q ) {

	q.onUpdate = @(__original) function( _properties )
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
