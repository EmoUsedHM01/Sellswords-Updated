::mods_hookExactClass("items/accessory/legend_stollwurm_blood_flask_item", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.Value = 2000;
	}

	o.getTooltip = function()
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