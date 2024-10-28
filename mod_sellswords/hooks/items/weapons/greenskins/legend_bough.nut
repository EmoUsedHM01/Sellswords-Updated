::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/greenskins/legend_bough", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.ShieldDamage = 38;
		this.m.Condition = 84.0;
		this.m.ConditionMax = 84.0;
		this.m.RegularDamage = 85;
		this.m.RegularDamageMax = 115;
	}
});
