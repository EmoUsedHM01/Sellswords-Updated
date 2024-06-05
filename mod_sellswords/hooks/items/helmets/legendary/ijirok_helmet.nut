::Mod_Sellswords.HooksMod.hook("scripts/items/helmets/legendary/ijirok_helmet", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		
		this.m.ConditionMax = 320;
		this.m.Condition = this.m.ConditionMax;
		this.m.StaminaModifier = -14;
	}
});
