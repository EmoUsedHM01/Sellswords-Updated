::mods_hookExactClass("items/weapons/legend_glaive", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 1500;
		this.m.ArmorDamageMult = 0.9;
		this.m.StaminaModifier = -10;
	}
});	