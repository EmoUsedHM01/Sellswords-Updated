::mods_hookExactClass("skills/perks/perk_legend_twirl", function ( o ) {

	o.onAdded <- function()
	{
		if (!this.m.Container.hasSkill("actives.rotation"))
			this.m.Container.add(::new("scripts/skills/actives/rotation"));
	}

	o.onRemoved <- function()
	{
		this.m.Container.removeByID("actives.rotation");
	}

});