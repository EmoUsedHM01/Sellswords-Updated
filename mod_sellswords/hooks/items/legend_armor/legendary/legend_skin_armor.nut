::Mod_Sellswords.HooksMod.hook("scripts/items/legend_armor/legendary/legend_skin_armor", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.ConditionMax = 220;
		this.m.Condition = this.m.ConditionMax;
	}
});
