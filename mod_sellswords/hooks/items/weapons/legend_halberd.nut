::mods_hookExactClass("items/weapons/legend_halberd", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Condition = 92.0;
		this.m.ConditionMax = 92.0;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 1.2;
		this.m.Value = 3200;
	}
});