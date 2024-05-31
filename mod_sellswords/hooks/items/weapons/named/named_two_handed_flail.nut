::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/named/named_two_handed_flail", function ( q ) {

	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		this.m.DirectDamageMult = 0.4;
	});
});
