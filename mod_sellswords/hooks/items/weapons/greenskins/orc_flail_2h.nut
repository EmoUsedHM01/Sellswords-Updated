::mods_hookExactClass("items/weapons/greenskins/orc_flail_2h", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.RegularDamage = 55;	
		this.m.RegularDamageMax = 110;
		this.m.ArmorDamageMult = 1.3;
		this.m.DirectDamageMult = 0.4;
	}
});	