::Mod_Sellswords.HooksMod.hook("scripts/items/legend_armor/cloth/legend_tunic_noble", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Value = 1000;
		this.m.Condition = 30;
		this.m.ConditionMax = 30;
		this.m.StaminaModifier = 0;
	}
});
