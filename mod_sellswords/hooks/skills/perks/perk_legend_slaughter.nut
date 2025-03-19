::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_slaughter", function ( q ) {
	// todo
	q.getBleeders <- function()
	{
		if (!("Entities" in this.Tactical))
			return 0;

		if (this.Tactical.Entities == null)
			return 0;

		if (!this.Tactical.isActive())
			return 0;

		local bleeders = 0.0;
		local actors = this.Tactical.Entities.getAllInstancesAsArray();

		foreach( a in actors )
			if (a.getSkills().hasSkill("effects.bleeding") || a.getSkills().hasSkill("effects.legend_grazed_effect"))
				bleeders = bleeders + 1.0;

		return bleeders;
	}

	q.onUpdate <- function( _properties )
	{
		_properties.Bravery += 2 * this.getBleeders();
		_properties.Initiative += 2 * this.getBleeders();
	}

});