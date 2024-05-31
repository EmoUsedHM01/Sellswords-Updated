::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/named/named_goblin_heavy_bow", function ( q ) {

	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		this.m.Value = 3300;
		this.m.Condition = 84.0;
		this.m.ConditionMax = 84.0;
		this.m.StaminaModifier = -4;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 55;
	});
});
