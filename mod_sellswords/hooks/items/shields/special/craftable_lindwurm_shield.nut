::mods_hookExactClass("items/shields/special/craftable_lindwurm_shield", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		
		this.m.MeleeDefense = 18;
		this.m.RangedDefense = 27;
		this.m.Condition = 76;
		this.m.ConditionMax = 76;
	}
})