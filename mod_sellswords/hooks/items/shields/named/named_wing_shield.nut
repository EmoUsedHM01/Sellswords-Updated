::mods_hookExactClass("items/shields/named/named_wing_shield", function(o) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(o, function() {
		this.m.MeleeDefense = 22;
		this.m.RangedDefense = 16;
		this.m.Condition = 48;
		this.m.ConditionMax = 48;
	});
})