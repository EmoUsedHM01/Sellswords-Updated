::Mod_Sellswords.HooksMod.hook("scripts/items/legend_armor/cloth/legend_knightly_robe", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Value = 800;
		this.m.Condition = 50;
		this.m.ConditionMax = 50;
		this.m.StaminaModifier = -3;
	}
});

