::mods_hookExactClass("items/weapons/legend_battle_glaive", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 2950;
		this.m.ArmorDamageMult = 1.0;
		this.m.StaminaModifier = -12;
	}
});	