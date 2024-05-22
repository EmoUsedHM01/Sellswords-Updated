::mods_hookExactClass("items/shields/named/named_lindwurm_shield", function(o) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(o, function() {
		this.m.Value = 1800;
		this.m.MeleeDefense = 16;
		this.m.RangedDefense = 27;
		this.m.StaminaModifier = -16;
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
	});
})