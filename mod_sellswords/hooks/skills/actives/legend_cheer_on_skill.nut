::mods_hookExactClass("skills/actives/legend_cheer_on_skill", function(o) {
	
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 10;
		this.m.MaxRange = 2;
	}

	local ws_getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = ws_getTooltip();

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/asset_medicine.png",
			text = "You have [color=" + ::Const.UI.Color.PositiveValue + "]" + ::World.Assets.getMedicine() + "[/color] medicine."
		})

		return ret;
	}

})