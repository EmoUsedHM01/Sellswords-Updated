::mods_hookExactClass("ambitions/oaths/oath_of_honor_ambition", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.OathBoonText = "Your men start battle at Confident morale. When you are at Confident morale, gain [color=" + this.Const.UI.Color.PositiveValue + "]+20%[/color] resolve.";
	}
})