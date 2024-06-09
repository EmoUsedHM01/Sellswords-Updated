::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_drink_beer_skill", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Description = "Give to an adjacent ally or drink beer to get buzzed, will get you drunk if already buzzed, and sick if you\'re already drunk. AP cost is doubled while engaged in melee, and anyone receiving the item needs to have a free bag slot.";
		this.m.ActionPointCost = 1;
	}

	::Mod_Sellswords.HookHelper.hookDoubleAP_CostIfEngageMelee(q);

});
