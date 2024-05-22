::mods_hookExactClass("items/weapons/oriental/handgonne", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.RegularDamage = 45;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 1;
	}
});	