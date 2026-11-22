::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_bullseye", function ( q ) {

	q.onUpdate = @( __original ) function ( _properties )
	{
		__original(_properties);

		// checked here and not only once in onAdded, a bow brings its own Mark Target and takes it along when it is unequipped
		if (!this.getContainer().hasActive(::Legends.Active.LegendMarkTarget))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendMarkTarget);
		}
	}

	q.onRemoved = @( __original ) function ()
	{
		__original();
		local skill = ::Legends.Actives.get(this, ::Legends.Active.LegendMarkTarget);

		// the one a bow brought stays
		if (skill != null && ::MSU.isNull(skill.getItem()))
		{
			this.getContainer().remove(skill);
		}
	}

});