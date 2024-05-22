::mods_hookExactClass("entity/tactical/enemies/goblin_fighter_low", function(o) {
	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
		this.m.BaseProperties.Hitpoints -= 10;
		this.m.Skills.update();			
	}
});	