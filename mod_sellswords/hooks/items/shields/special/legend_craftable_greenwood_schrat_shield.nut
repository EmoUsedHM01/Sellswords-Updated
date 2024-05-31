::Mod_Sellswords.HooksMod.hook("scripts/items/shields/special/legend_craftable_greenwood_schrat_shield", function ( q )  {

	q.create = @(__original) function()
	{
		__original();
		
		this.m.MeleeDefense = 28;
		this.m.RangedDefense = 22;
		this.m.Condition = 80;
		this.m.ConditionMax = 80;
	}
});
