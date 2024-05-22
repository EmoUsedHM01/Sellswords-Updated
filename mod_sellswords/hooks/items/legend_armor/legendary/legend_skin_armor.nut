::mods_hookExactClass("items/legend_armor/legendary/legend_skin_armor", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.ConditionMax = 220;
		this.m.Condition = this.m.ConditionMax;
	}
	
});