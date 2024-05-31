::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/legend_halberd", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original()

		this.m.Condition = 92.0;
		this.m.ConditionMax = 92.0;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 1.2;
		this.m.Value = 3200;
	}
});
