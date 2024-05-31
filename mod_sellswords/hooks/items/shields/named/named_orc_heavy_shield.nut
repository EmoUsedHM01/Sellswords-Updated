::Mod_Sellswords.HooksMod.hook("scripts/items/shields/named/named_orc_heavy_shield", function( q ) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		this.m.Value = 1000;
		this.m.MeleeDefense = 20;
		this.m.RangedDefense = 16;
		this.m.StaminaModifier = -25;
		this.m.Condition = 90;
		this.m.ConditionMax = 90;
	});
});
