::mods_hookExactClass("skills/perks/perk_ptr_swift_stabs", function ( o )
{
	o.onAfterUpdate = function ( _properties )
	{
		if (!this.m.IsSpent && this.isEnabled())
		{
			local skills = this.getContainer().getActor().getMainhandItem().getSkills();

			foreach( skill in skills )
			{
				if (skill.isAttack() && !skill.isRanged())
				{
					if (this.getContainer().hasSkill("perk.crGrandslam"))
					{
						skill.m.ActionPointCost = this.Math.max(4, skill.m.ActionPointCost - 2);
					}
					else
					{
						skill.m.ActionPointCost = this.Math.max(2, skill.m.ActionPointCost - 2);
					}
				}
			}
		}
	};
});