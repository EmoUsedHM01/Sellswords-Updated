::mods_hookExactClass("items/shields/named/named_red_white_shield", function(o) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(o, function() {
		this.m.Value = 1200;
		this.m.MeleeDefense = 16;
		this.m.RangedDefense = 27;
	});
})