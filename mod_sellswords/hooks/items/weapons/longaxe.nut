::mods_hookNewObject("items/weapons/longaxe", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original()

		this.m.Value = 1300;
		this.m.ShieldDamage = 24;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -14;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 70;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 1.2;
		this.m.DirectDamageMult = 0.3;
	}
});
