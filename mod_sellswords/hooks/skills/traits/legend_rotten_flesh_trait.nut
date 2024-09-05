::Mod_Sellswords.HooksMod.hook("scripts/skills/traits/legend_rotten_flesh_trait", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = "ui/traits/necro_rotten_flesh.png";
	}

});