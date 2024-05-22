::mods_hookExactClass("items/weapons/oriental/heavy_southern_mace", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()
		this.m.ArmorDamageMult = 1.25;
	}
});