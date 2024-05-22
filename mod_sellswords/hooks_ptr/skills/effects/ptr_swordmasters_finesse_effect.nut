::mods_hookExactClass("skills/effects/ptr_swordmasters_finesse_effect", function ( o )
{
	o.getSkillBonus = function ()
	{
		//return this.Math.max(1, this.getContainer().getActor().getLevel() - 8) * (this.getContainer().hasSkill("perk.ptr_swordmaster_precise") ? 2 : 1);
		return this.Math.max(1, this.getContainer().getActor().getLevel() - (this.getContainer().hasSkill("perk.ptr_swordmaster_precise") ? 0 : 10));			
	}
});	