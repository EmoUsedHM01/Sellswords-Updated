::mods_hookExactClass("skills/perks/perk_ptr_two_for_one", function ( o )
{
	o.onAfterUpdate = function (_properties)
	{
		local skills = [];

		skills.push(this.getContainer().getSkillByID("actives.thrust"));
		skills.push(this.getContainer().getSkillByID("actives.legend_glaive_slash"));
		skills.push(this.getContainer().getSkillByID("actives.prong"));
		skills.push(this.getContainer().getSkillByID("actives.jab"));
		skills.push(this.getContainer().getSkillByID("actives.throw_javelin"));
		
		foreach (s in skills)
		{
			if (s != null && s.m.ActionPointCost > 0)
			{
				s.m.ActionPointCost -= 1;
			}
		}
	}
});	