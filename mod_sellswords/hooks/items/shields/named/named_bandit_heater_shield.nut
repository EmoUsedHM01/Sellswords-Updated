::mods_hookExactClass("items/shields/named/named_bandit_heater_shield", function(o) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(o, function() {
		this.m.Value = 900;
		this.m.MeleeDefense = 22;
		this.m.RangedDefense = 16;
		this.m.Condition = 48;
		this.m.ConditionMax = 48;
	});
})