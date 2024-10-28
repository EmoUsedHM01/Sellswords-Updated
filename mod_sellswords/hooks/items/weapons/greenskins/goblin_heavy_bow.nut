::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/greenskins/goblin_heavy_bow", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.Value = 1800;
		this.m.Condition = 90.0;
		this.m.ConditionMax = 90.0;
		this.m.StaminaModifier = -6;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 55;
		this.m.DirectDamageAdd = 0.1;
	}
});	
