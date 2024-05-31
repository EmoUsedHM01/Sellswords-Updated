::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/greenskins/goblin_falchion", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original()

		this.m.Condition = 64;
		this.m.ConditionMax = 64;
	}
	
});
