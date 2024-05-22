::mods_hookExactClass("skills/actives/legend_drink_heartwood_sap_skill", function(o) {
	
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.Description = "Give to an adjacent ally or drink yourself a flask of heartwood sap that promises to render someone indomitable for three turns. AP cost is doubled while engaged in melee, and anyone receiving the item needs to have a free bag slot.";
	}

	::Mod_Sellswords.HookHelper.hookDoubleAP_CostIfEngageMelee(o);

	local ws_getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = ws_getTooltip();

		foreach (tooltip in ret)
		{
			if (!("icon" in tooltip) || tooltip.icon != "ui/icons/days_wounded.png") continue;

			tooltip.text = "This character will gather all his physical strength and willpower to become indomitable for three turns.";
			break;
		}

		return ret;
	}

})