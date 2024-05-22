::mods_hookExactClass("skills/actives/legend_drink_stollwurm_blood_skill", function(o) {
	
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.Description = "Give to an adjacent ally or drink yourself a flask of stollwurm blood that damaging adjacent attackers whenever they deal hitpoint damage or receive hitpoint damage for three turns. AP cost is doubled while engaged in melee, and anyone receiving the item needs to have a free bag slot.";	
	}

	::Mod_Sellswords.HookHelper.hookDoubleAP_CostIfEngageMelee(o);

	local ws_getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = ws_getTooltip();

		foreach (tooltip in ret)
		{
			if (!("icon" in tooltip) || tooltip.icon != "ui/icons/days_wounded.png") continue;

			tooltip.icon = "ui/icons/special.png";
			tooltip.text = "This character\'s blood burns with acid, damaging adjacent attackers whenever they deal hitpoint damage or receive hitpoint damage.";
			break;
		}

		return ret;
	}
})