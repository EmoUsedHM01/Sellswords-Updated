::mods_hookExactClass("items/weapons/named/legend_named_blacksmith_hammer", function(o) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(o, function() {
		this.m.ArmorDamageMult = 2.5;
		this.m.DirectDamageAdd = 0.2;
	});
});