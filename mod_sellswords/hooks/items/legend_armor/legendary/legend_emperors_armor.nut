::Mod_Sellswords.HooksMod.hook("scripts/items/legend_armor/legendary/legend_emperors_armor", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.ConditionMax = 555;
		this.m.Condition = this.m.ConditionMax;
		this.m.StaminaModifier = -48;
	}
});
