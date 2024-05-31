::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/named/named_spetum", function ( q ) {

	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		this.m.Value = 3000;
		this.m.RegularDamage = 65;
		this.m.RegularDamageMax = 80;
	});
});
