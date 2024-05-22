::mods_hookExactClass("items/accessory/legend_skin_ghoul_blood_flask_item", function ( o )
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
			icon = "ui/icons/days_wounded.png",
			text = "Restores up to [color=" + this.Const.UI.Color.PositiveValue + "]75%[/color] of missing health and heal wounds"
		});
		return result;
	}
	
});	