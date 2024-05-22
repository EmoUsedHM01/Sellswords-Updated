::mods_hookExactClass("items/shields/special/legend_craftable_greenwood_schrat_shield", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		
		this.m.MeleeDefense = 28;
		this.m.RangedDefense = 22;
		this.m.Condition = 80;
		this.m.ConditionMax = 80;
	}
})