::mods_hookExactClass("items/weapons/reinforced_wooden_flail", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 800;
		this.m.Condition = 50.0;
		this.m.ConditionMax = 50.0;
		this.m.StaminaModifier = -8;
		this.m.RegularDamage = 25;
		this.m.RegularDamageMax = 50;
	}
});	