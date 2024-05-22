::mods_hookExactClass("items/weapons/legend_military_voulge", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Condition = 92.0;
		this.m.ConditionMax = 92.0;
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 85;
		this.m.RegularDamageMax = 105;
		this.m.ArmorDamageMult = 1;
		this.m.DirectDamageMult = 0.25;
	}
});