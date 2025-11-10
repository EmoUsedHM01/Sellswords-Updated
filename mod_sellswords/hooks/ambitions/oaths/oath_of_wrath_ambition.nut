::Mod_Sellswords.HooksMod.hook("scripts/ambitions/oaths/oath_of_wrath_ambition", function( q ) {

	q.create = @( __original ) function()
	{
		__original();
		this.m.OathBurdenText = "Your men have [color=%negative%]-5[/color] Melee Defense and [color=%negative%]-5[/color] Ranged Defense.";
	}
});
