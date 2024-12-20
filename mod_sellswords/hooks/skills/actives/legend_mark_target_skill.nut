::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_mark_target_skill", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 15;	
		this.m.IsAttack = true;	
	}
		
	q.getTooltip = @( __original ) function ()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Leave your opponent marked, reducing their ranged defense by 20, melee defense by 10"
		});
		return ret;
	};
});
