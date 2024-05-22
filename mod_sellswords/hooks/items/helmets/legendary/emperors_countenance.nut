::mods_hookExactClass("items/helmets/legendary/emperors_countenance", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()
		
		this.m.ConditionMax = 555;
		this.m.Condition = this.m.ConditionMax;
		this.m.StaminaModifier = -32;
	}
});