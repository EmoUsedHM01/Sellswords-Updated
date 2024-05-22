::mods_hookExactClass("items/weapons/legend_katar", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 1800;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.2;
		this.m.DirectDamageAdd = 0.1;		
	}
		
});	