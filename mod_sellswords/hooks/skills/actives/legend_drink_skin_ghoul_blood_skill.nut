::mods_hookExactClass("skills/actives/legend_drink_skin_ghoul_blood_skill", function(o) {
	
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.Description = "Give to an adjacent ally or drink yourself a flask of skin ghoul blood that promises to knit wounds and heal damaged flesh. AP cost is doubled while engaged in melee, and anyone receiving the item needs to have a free bag slot.";
	}

	::Mod_Sellswords.HookHelper.hookDoubleAP_CostIfEngageMelee(o);

})