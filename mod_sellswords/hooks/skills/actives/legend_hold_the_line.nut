::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_hold_the_line", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Description = "Instruct your mercenaries to push their advantages, raising melee defence by 10 within 4 tiles";
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 20;
	}

	q.getTooltip = @( __original ) function()
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
