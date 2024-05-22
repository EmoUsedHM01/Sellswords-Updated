::mods_hookExactClass("items/weapons/greenskins/legend_bone_carver", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 65;
	}
});	