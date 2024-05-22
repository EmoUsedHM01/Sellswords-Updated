::mods_hookExactClass("items/shields/special/craftable_schrat_shield", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		
		this.m.MeleeDefense = 22;
		this.m.RangedDefense = 18;
		this.m.Condition = 48;
		this.m.ConditionMax = 48;
	}
})