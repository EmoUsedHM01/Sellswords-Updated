::Mod_Sellswords.HooksMod.hook("scripts/items/accessory/legend_skin_ghoul_blood_flask_item", function ( q ) {

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
			icon = "ui/icons/days_wounded.png",
			text = "Restores up to [color=" + this.Const.UI.Color.PositiveValue + "]75%[/color] of missing health and heal wounds"
		});
		return result;
	}	
});
