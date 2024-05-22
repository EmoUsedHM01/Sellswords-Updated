::mods_hookExactClass("items/accessory/legend_heartwood_sap_flask_item", function ( o )
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
			text = "This character will gather all his physical strength and willpower to become indomitable for three turns"
		});
		return result;
	}

});	