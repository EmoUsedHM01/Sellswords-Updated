::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/named/named_flail", function ( q ) {

	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		this.m.StaminaModifier = -9;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 60;
	});
});
