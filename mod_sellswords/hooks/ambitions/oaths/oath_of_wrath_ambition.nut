::Mod_Sellswords.HooksMod.hook("scripts/ambitions/oaths/oath_of_wrath_ambition", function( q ) {

	q.create = @( __original ) function()
	{
		__original();
		this.m.OathBurdenText = "Your men have [color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] Melee Defense and [color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] Ranged Defense.";
	}
});
