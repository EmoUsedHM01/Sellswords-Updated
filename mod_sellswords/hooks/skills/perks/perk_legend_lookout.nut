::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_lookout", function ( q ) {

	q.onUpdate = @( __original ) function ( _properties )
	{
		_properties.Vision += 1;
		if (!this.World.getTime().IsDaytime && this.getContainer().getActor().isPlacedOnMap())
		{
			_properties.Vision += 1;
			_properties.RangedSkillMult *= 1.215;
			_properties.RangedDefenseMult *= 1.215;
		}
	}

});