::mods_hookExactClass("items/weapons/named/named_flail", function(o) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(o, function() {
		this.m.StaminaModifier = -9;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 60;
	});
});