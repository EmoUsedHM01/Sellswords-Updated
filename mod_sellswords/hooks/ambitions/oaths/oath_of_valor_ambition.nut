::mods_hookExactClass("ambitions/oaths/oath_of_valor_ambition", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.OathBoonText = "Your men will never flee while in battle, while all attributes debuff cause by low morale will be [color=" + this.Const.UI.Color.PositiveValue + "]halved[/color].";
	}
})