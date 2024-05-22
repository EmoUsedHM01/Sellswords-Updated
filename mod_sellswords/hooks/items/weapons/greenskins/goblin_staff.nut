::mods_hookExactClass("items/weapons/greenskins/goblin_staff", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.RegularDamage = 15;
		this.m.RegularDamageMax = 25;
		this.m.ArmorDamageMult = 0.35;
		this.m.DirectDamageAdd = 0.4;	
	}
});	