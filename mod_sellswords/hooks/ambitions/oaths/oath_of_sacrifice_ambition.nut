::mods_hookExactClass("ambitions/oaths/oath_of_sacrifice_ambition", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.OathBoonText = "None of your men take any crowns as wage. And the threshold to sustain injuries on getting hit is increased by [color=" + this.Const.UI.Color.PositiveValue + "]20%[/color].";
	}
})