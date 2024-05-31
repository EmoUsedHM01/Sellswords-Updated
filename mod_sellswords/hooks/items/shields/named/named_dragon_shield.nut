::Mod_Sellswords.HooksMod.hook("scripts/items/shields/named/named_dragon_shield", function( q ) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		this.m.Value = 1200;
		this.m.MeleeDefense = 16;
		this.m.RangedDefense = 27;
	});
});
