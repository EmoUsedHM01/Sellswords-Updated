::Mod_Sellswords.HooksMod.hook("scripts/items/legend_armor/legendary/legend_ijirok_armor", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.ConditionMax = 320;
		this.m.Condition = this.m.ConditionMax;
		this.m.StaminaModifier = -24;
	}
});
