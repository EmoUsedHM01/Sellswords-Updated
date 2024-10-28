::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/polehammer", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.Value = 1550;
		this.m.ShieldDamage = 0;
		this.m.Condition = 100.0;
		this.m.ConditionMax = 100.0;
		this.m.StaminaModifier = -14;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 1.75;
		this.m.DirectDamageMult = 0.5;
	}
	
});
