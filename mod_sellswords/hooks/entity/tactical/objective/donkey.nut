::mods_hookExactClass("entity/tactical/objective/donkey", function(o) {
	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
	}		
});		