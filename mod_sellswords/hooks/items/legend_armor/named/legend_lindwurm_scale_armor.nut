::Mod_Sellswords.HooksMod.hook("scripts/items/legend_armor/named/legend_lindwurm_scale_armor", function ( q ) {

	// the values of the SSU Lindwurm armour this replaced, Legends has 60 and -6
	q.create = @(__original) function()
	{
		__original();

		this.m.ConditionMax = 130;
		this.m.Condition = this.m.ConditionMax;
		this.m.StaminaModifier = -13;
	}
});
