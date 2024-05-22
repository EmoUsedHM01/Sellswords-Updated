::mods_hookExactClass("items/weapons/warbrand", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 2200;
		this.m.StaminaModifier = -8;
		this.m.RegularDamageMax = 70;
		this.m.DirectDamageAdd = 0.1;			
		this.m.ChanceToHitHead = 10;
	}
});	