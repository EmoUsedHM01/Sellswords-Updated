::Mod_Sellswords.HooksMod.hook("scripts/ambitions/oaths/oath_of_valor_ambition", function(q)
{
	q.create = ( __original ) function()
	{
		__original();
		this.m.OathBoonText = "Your men will never flee while in battle, while all attributes debuff cause by low morale will be [color=" + this.Const.UI.Color.PositiveValue + "]halved[/color].";
	}
})