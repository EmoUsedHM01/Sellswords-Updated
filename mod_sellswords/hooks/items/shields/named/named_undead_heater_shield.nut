::Mod_Sellswords.HooksMod.hook("scripts/items/shields/named/named_undead_heater_shield", function( q ) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		this.m.Value = 900;
		this.m.MeleeDefense = 22;
		this.m.RangedDefense = 16;
	});
});
