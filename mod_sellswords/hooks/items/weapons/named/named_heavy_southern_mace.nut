::mods_hookExactClass("items/weapons/named/named_heavy_southern_mace", function(o) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(o, function() {
		this.m.ArmorDamageMult = 1.25;
	});
});