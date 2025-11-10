::Mod_Sellswords.HooksMod.hook("scripts/ambitions/oaths/oath_of_honor_ambition", function( q ) {

	q.create = @( __original ) function()
	{
		__original();
		this.m.OathBoonText = "Your men start battle at Confident morale. When you are at Confident morale, gain [color=%positive%]+20%[/color] resolve.";
	}
});
