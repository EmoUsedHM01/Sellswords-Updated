::mods_hookExactClass("items/helmets/legendary/ijirok_helmet", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()
		
		this.m.ConditionMax = 320;
		this.m.Condition = this.m.ConditionMax;
		this.m.StaminaModifier = -14;
	}
});