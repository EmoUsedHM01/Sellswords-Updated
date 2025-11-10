::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_cheer_on_skill", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 10;
		this.m.MaxRange = 2;
	}

	q.getTooltip = @( __original ) function()
	{
		local ret = __original();

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/asset_medicine.png",
			text = "You have [color=%positive%]" + ::World.Assets.getMedicine() + "[/color] medicine."
		});

		return ret;
	}

});
