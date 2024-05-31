::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/legend_ranged_flail", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original()

		this.m.Value = 1350;
		this.m.ShieldDamage = 0;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -14;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.3;
	}
	
});
