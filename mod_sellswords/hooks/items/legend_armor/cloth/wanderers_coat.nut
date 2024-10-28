::Mod_Sellswords.HooksMod.hook("scripts/items/legend_armor/cloth/wanderers_coat", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Value = 200;
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
		this.m.StaminaModifier = -3;
	}
});
