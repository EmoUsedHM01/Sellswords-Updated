::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/reinforced_wooden_flail", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original()

		this.m.Value = 800;
		this.m.Condition = 50.0;
		this.m.ConditionMax = 50.0;
		this.m.StaminaModifier = -8;
		this.m.RegularDamage = 25;
		this.m.RegularDamageMax = 50;
	}
});	
