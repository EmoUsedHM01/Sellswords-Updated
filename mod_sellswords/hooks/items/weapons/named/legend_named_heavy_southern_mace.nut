::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/named/legend_named_heavy_southern_mace", function ( q ) {

	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		this.m.ArmorDamageMult = 1.25;
	});
});
