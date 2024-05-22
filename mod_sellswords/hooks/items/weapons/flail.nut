::mods_hookExactClass("items/weapons/flail", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 2200;
		this.m.StaminaModifier = -9;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 60;
	}
});	