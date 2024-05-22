::mods_hookExactClass("items/weapons/legend_reinforced_flail", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 1400;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 75;
		this.m.DirectDamageMult = 0.4;
	}
});	