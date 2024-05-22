::mods_hookExactClass("items/shields/named/named_rider_on_horse_shield", function(o) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(o, function() {
		this.m.Value = 1500;
		this.m.MeleeDefense = 22;
		this.m.RangedDefense = 16;
		this.m.Condition = 48;
		this.m.ConditionMax = 48;
	});
})