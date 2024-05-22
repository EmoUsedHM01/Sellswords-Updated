::Mod_Sellswords.HooksMod.hook("ambitions/oaths/oath_of_endurance_ambition", function(q)
{
	q.create = @( __original ) function()
	{
		__original();
		this.m.OathBurdenText = "You can only take up to [color=" + this.Const.UI.Color.NegativeValue + "]14[/color] men into battle.";
	}
	q.onUpdateScore = @( __original) function()
	{
		this.m.Score = 10000;
	}
	q.onUpdateEffect = @( __original ) function()
	{
		this.World.Assets.m.BrothersMaxInCombat = 18;
	}
});
