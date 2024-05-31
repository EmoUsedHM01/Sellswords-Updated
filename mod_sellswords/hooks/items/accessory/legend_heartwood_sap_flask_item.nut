::Mod_Sellswords.HooksMod.hook("scripts/items/accessory/legend_heartwood_sap_flask_item", function ( q ) {

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
			text = "This character will gather all his physical strength and willpower to become indomitable for three turns"
		});
		return result;
	}
});
