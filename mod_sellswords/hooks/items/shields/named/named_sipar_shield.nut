::mods_hookExactClass("items/shields/named/named_sipar_shield", function(o) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(o, function() {
		this.m.Value = 2250;
		this.m.MeleeDefense = 20;
		this.m.RangedDefense = 20;
		this.m.Condition = 72;
		this.m.ConditionMax = 72;
	});
})