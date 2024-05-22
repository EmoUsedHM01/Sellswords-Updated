::mods_hookExactClass("items/weapons/greenskins/goblin_crossbow", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 3500;
		this.m.Condition = 80;
		this.m.ConditionMax = 80;
		this.m.StaminaModifier = -15;
		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 75;
		this.m.DirectDamageAdd = 0.05;
	}
});	