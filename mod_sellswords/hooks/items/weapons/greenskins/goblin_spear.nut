::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/greenskins/goblin_spear", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.Condition = 48;
		this.m.ConditionMax = 48;
	}
	
});
