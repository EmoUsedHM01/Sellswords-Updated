::mods_hookExactClass("ambitions/oaths/oath_of_wrath_ambition", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.OathBurdenText = "Your men have [color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] Melee Defense and [color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] Ranged Defense.";
	}
})