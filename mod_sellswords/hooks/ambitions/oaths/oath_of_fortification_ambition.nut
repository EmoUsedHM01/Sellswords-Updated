::Mod_Sellswords.HooksMod.hook("ambitions/oaths/oath_of_fortification_ambition", function(q)
{
	q.create = @( __original ) function()
	{
		__original();
		this.m.OathBoonText = "Your men build up [color=" + this.Const.UI.Color.NegativeValue + "]25%[/color] less Fatigue when using shield skills. The \'Shield Wall\' skill now grants an additional [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee Defense and [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Ranged Defense. The \'Knock Back\' skill now staggers targets on hit.";
	}
})