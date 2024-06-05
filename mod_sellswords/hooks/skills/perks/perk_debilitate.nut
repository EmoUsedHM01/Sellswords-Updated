::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_debilitate", function ( q ) {

	q.onRemoved <- function ()
	{
		this.m.Container.removeByID("actives.debilitate");
	};
});
