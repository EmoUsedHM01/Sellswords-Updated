::Mod_Sellswords.HooksMod.hook("scripts/items/shields/special/craftable_kraken_shield", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		
		this.m.Value = 1400;
		this.m.MeleeDefense = 26;
		this.m.RangedDefense = 26;
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
	}
});
