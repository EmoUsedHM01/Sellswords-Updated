::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_mastery_fist", function ( q ) {

	q.onAfterUpdate <- function ( _properties )
	{
		local handToHand = this.getContainer().getSkillByID("actives.hand_to_hand");

		if (handToHand != null && handToHand.m.ActionPointCost >= 1)
			handToHand.m.ActionPointCost -= 1;

		local grapple = this.getContainer().getSkillByID("actives.legend_grapple");

		if (grapple != null && grapple.m.ActionPointCost >= 1)
			grapple.m.ActionPointCost -= 1;
		
		local kick = this.getContainer().getSkillByID("actives.legend_kick");

		if (kick != null && kick.m.ActionPointCost >= 1)
			kick.m.ActionPointCost -= 1;
	}

});