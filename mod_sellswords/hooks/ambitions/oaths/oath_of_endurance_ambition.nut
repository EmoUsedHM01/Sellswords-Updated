::mods_hookExactClass("ambitions/oaths/oath_of_endurance_ambition", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.OathBurdenText = "You can only take up to [color=" + this.Const.UI.Color.NegativeValue + "]14[/color] men into battle.";
	}
	o.onUpdateScore = function()
	{
		this.m.Score = 10000;
	}
	o.onUpdateEffect = function()
	{
		this.World.Assets.m.BrothersMaxInCombat = 18;
	}
})