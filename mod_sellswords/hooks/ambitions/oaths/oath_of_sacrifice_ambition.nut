::Mod_Sellswords.HooksMod.hook("scripts/ambitions/oaths/oath_of_sacrifice_ambition", function( q ) {

	q.create = @( __original ) function()
	{
		__original();
		this.m.OathBoonText = "None of your men take any crowns as wage. And the threshold to sustain injuries on getting hit is increased by [color=" + this.Const.UI.Color.PositiveValue + "]20%[/color].";
	}
})