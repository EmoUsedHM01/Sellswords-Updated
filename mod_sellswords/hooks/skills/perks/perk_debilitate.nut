::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_debilitate", function ( q ) {

	q.onRemoved <- function ()
	{
		::Legends.Actives.remove(this.m.Container, ::Legends.Active.Debilitate);
	}

});