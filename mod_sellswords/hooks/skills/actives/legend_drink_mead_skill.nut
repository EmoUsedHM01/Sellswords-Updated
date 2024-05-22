::mods_hookExactClass("skills/actives/legend_drink_mead_skill", function(o) {
	
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.Description = "Give to an adjacent ally or drink mead to get warmed, will get you drunk if already warmed, and sick if you\'re already drunk. AP cost is doubled while engaged in melee, and anyone receiving the item needs to have a free bag slot.";
		this.m.ActionPointCost = 1;
	}

	::Mod_Sellswords.HookHelper.hookDoubleAP_CostIfEngageMelee(o);

})