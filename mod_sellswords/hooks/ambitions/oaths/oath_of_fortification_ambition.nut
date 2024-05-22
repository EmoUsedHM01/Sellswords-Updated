::mods_hookExactClass("ambitions/oaths/oath_of_fortification_ambition", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.OathBoonText = "Your men build up [color=" + this.Const.UI.Color.NegativeValue + "]25%[/color] less Fatigue when using shield skills. The \'Shield Wall\' skill now grants an additional [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee Defense and [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Ranged Defense. The \'Knock Back\' skill now staggers targets on hit.";
	}
})