::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/oriental/swordlance", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.Value = 1500;
		this.m.ShieldDamage = 0;
		this.m.Condition = 52.0;
		this.m.ConditionMax = 52.0;
		this.m.StaminaModifier = -14;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.3;
	}
	
});
