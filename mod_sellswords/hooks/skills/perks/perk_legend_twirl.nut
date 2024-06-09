::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_twirl", function ( q ) {

	q.onAdded <- function()
	{
		if (!this.m.Container.hasSkill("actives.rotation"))
			this.m.Container.add(::new("scripts/skills/actives/rotation"));
	}

	q.onRemoved <- function()
	{
		this.m.Container.removeByID("actives.rotation");
	}

});