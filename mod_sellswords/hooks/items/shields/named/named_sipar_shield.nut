::Mod_Sellswords.HooksMod.hook("scripts/items/shields/named/named_sipar_shield", function( q ) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		this.m.Value = 2250;
		this.m.MeleeDefense = 20;
		this.m.RangedDefense = 20;
		this.m.Condition = 72;
		this.m.ConditionMax = 72;
	});
});
