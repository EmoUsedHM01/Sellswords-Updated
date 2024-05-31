::Mod_Sellswords.HooksMod.hook("scripts/items/shields/named/named_undead_kite_shield", function( q ) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		this.m.MeleeDefense = 16;
		this.m.RangedDefense = 27;
	});
});
