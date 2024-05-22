::mods_hookExactClass("items/shields/special/craftable_kraken_shield", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		
		this.m.Value = 1400;
		this.m.MeleeDefense = 26;
		this.m.RangedDefense = 26;
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
	}
})