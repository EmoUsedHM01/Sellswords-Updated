::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/named/named_two_handed_spiked_mace", function ( q ) {

	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		this.m.ShieldDamage = 26;
		this.m.Condition = 84.0;
		this.m.ConditionMax = 84.0;
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 1.2;
	});
});
