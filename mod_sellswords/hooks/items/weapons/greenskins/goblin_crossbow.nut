::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/greenskins/goblin_crossbow", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.Value = 3500;
		this.m.Condition = 80;
		this.m.ConditionMax = 80;
		this.m.StaminaModifier = -15;
		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 75;
		this.m.DirectDamageAdd = 0.05;
	}
});	
