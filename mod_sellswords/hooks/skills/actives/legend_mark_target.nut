::mods_hookExactClass("skills/actives/legend_mark_target", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 15;	
		this.m.IsAttack = true;	
	}
		
	o.getTooltip = function ()
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