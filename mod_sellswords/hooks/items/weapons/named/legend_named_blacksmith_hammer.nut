::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/named/legend_named_blacksmith_hammer", function ( q ) {

	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		this.m.ArmorDamageMult = 2.5;
		this.m.DirectDamageAdd = 0.2;
	});
});
