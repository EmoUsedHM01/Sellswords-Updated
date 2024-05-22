::mods_hookExactClass("items/shields/named/named_bandit_kite_shield", function(o) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(o, function() {
		this.m.Value = 1050;
		this.m.MeleeDefense = 16;
		this.m.RangedDefense = 27;
	});
})