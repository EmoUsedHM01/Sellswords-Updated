::mods_hookExactClass("items/shields/named/named_full_metal_heater_shield", function(o) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(o, function() {
		this.m.Value = 2250;
		this.m.MeleeDefense = 22;
		this.m.RangedDefense = 16;
		this.m.Condition = 72;
		this.m.ConditionMax = 72;
	});
})