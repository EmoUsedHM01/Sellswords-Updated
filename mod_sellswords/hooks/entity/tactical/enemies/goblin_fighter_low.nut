::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/enemies/goblin_fighter_low", function(q)
{
	q.onInit = @( __original ) function()
	{
		this.m.BaseProperties.Hitpoints -= 10;
		this.m.Skills.update();			
	}
});
