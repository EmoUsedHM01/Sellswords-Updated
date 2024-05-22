::mods_hookExactClass("skills/actives/legend_hold_the_line", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Description = "Instruct your mercenaries to push their advantages, raising melee defence by 10 within 4 tiles";
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 20;
	}

	o.getTooltip = function()
	{
		local ret = this.getDefaultUtilityTooltip();

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text =  "[color=" + this.Const.UI.Color.PositiveValue + "]10[/color] defense and resolve to all allies within [color=" + this.Const.UI.Color.PositiveValue + "]4[/color] tiles for one turn"
		});

		return ret;
	}

});	