::mods_hookExactClass("items/weapons/greenskins/goblin_bow", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 500;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -4;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 45;
		this.m.DirectDamageAdd = 0.1;
	}
});	