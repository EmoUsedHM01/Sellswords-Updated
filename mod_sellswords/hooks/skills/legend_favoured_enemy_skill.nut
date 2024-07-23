::Mod_Sellswords.HooksMod.hook("scripts/skills/legend_favoured_enemy_skill", function ( q ) {
	
	q.onUpdate = @(__original) function( _properties )
	{
		local actor = this.getContainer().getActor();
		if (actor.m.Skills.hasSkill(this.m.ID) && !actor.getFlags().has(this.m.ID + "_refunded"))
		{
			local stats = this.getTotalKillStats();
			if (stats.HitChance >= 15)
			{
				actor.m.PerkPoints += 1;
				actor.getFlags().add(this.m.ID + "_refunded");
			}
		}

		__original(_properties);
	};

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		if (this.getContainer().getActor().getFlags().has(this.m.ID + "_refunded"))
		{
			// Perk Point has been refunded
			ret.push({
				id = 15,
				type = "hint",
				icon = "ui/icons/unlocked_small.png",
				text = "The perk point spent on this perk has been refunded."
			});
		}
		
		return ret;
	};
});
