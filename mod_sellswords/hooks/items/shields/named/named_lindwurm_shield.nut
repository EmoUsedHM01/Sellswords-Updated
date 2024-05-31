::Mod_Sellswords.HooksMod.hook("scripts/items/shields/named/named_lindwurm_shield", function( q ) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		this.m.Value = 1800;
		this.m.MeleeDefense = 16;
		this.m.RangedDefense = 27;
		this.m.StaminaModifier = -16;
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
	});
});
