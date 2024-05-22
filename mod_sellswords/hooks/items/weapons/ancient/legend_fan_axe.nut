::mods_hookExactClass("items/weapons/ancient/legend_fan_axe", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 75;
	}
});