::mods_hookExactClass("items/weapons/legend_chain", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 600;
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;
		this.m.StaminaModifier = -14;
		this.m.RegularDamageMax = 35;
		this.m.ArmorDamageMult = 0.6;
		this.m.DirectDamageMult = 0.3;
		this.m.DirectDamageAdd = 0.15;
	}
});	