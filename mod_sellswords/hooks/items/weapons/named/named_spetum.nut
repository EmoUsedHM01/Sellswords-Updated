::mods_hookExactClass("items/weapons/named/named_spetum", function(o) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(o, function() {
		this.m.Value = 3000;
		this.m.RegularDamage = 65;
		this.m.RegularDamageMax = 80;
	});
});