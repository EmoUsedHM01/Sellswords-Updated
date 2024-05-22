::mods_hookExactClass("items/legend_armor/legendary/legend_ijirok_armor", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.ConditionMax = 320;
		this.m.Condition = this.m.ConditionMax;
		this.m.StaminaModifier = -24;
	}
	
});