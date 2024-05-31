::Mod_Sellswords.HooksMod.hook("scripts/items/accessory/legend_stollwurm_blood_flask_item", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Value = 2000;
	}

	q.getTooltip = @(__original) function()
	{
		local result = this.accessory.getTooltip();
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "damaging adjacent attackers whenever they deal hitpoint damage or receive hitpoint damage."
		});
		return result;
	}
});
