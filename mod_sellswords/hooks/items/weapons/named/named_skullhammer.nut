::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/named/named_skullhammer", function ( q ) {

	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.ShieldDamage = 30;
		this.m.StaminaModifier = -18;
		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 75;
		this.m.ArmorDamageMult = 1.9;
	});
});
