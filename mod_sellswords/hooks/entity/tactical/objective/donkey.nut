::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/objective/donkey", function(q)
{
	q.onInit = @(__original) function()
	{
		__original();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
	}		
});
