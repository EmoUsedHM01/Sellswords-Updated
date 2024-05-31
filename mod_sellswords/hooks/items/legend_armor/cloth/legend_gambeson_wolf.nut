::Mod_Sellswords.HooksMod.hook("scripts/items/legend_armor/cloth/legend_gambeson_wolf", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Value = 700;
		this.m.Condition = 80;
		this.m.ConditionMax = 80;
		this.m.StaminaModifier = -9;
	}
});
