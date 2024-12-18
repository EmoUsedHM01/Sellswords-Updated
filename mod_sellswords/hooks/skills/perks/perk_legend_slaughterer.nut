::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_slaughterer", function ( q ) {


	q.onUpdate = @( __original ) function ( _properties )
	{
		__original(_properties);
		_properties.FlatOnKillOtherActorModifier -= 10;
	}
});
