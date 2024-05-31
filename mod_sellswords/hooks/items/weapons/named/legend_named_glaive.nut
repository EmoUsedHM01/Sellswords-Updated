::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/named/legend_named_glaive", function ( q ) {

	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		this.m.Value = 4000;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 60;
	});
});
