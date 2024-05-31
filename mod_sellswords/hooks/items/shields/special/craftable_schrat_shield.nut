::Mod_Sellswords.HooksMod.hook("scripts/items/shields/special/craftable_schrat_shield", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		
		this.m.MeleeDefense = 22;
		this.m.RangedDefense = 18;
		this.m.Condition = 48;
		this.m.ConditionMax = 48;
	}
});
