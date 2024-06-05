::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/debilitate", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 20;
	}
});
