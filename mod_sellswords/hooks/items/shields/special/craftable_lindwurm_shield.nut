::Mod_Sellswords.HooksMod.hook("scripts/items/shields/special/craftable_lindwurm_shield", function ( q )  {

	q.create = @(__original) function()
	{
		__original();
		
		this.m.MeleeDefense = 18;
		this.m.RangedDefense = 27;
		this.m.Condition = 76;
		this.m.ConditionMax = 76;
	}
});
