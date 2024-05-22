::mods_hookExactClass("items/weapons/oriental/firelance", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()
		this.m.Ammo = 3;
		this.m.AmmoMax = 3;
		this.m.AmmoCost = 3;
		this.setCategories("Spear/Firearm, One-Handed");
	}
});