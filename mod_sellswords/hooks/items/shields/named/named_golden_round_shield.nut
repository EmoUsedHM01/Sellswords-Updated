::mods_hookExactClass("items/shields/named/named_golden_round_shield", function(o) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(o, function() {
		this.m.Value = 2250;
		this.m.MeleeDefense = 22;
		this.m.RangedDefense = 19;
		this.m.StaminaModifier = -18;
		this.m.Condition = 72;
		this.m.ConditionMax = 72;
	});
})