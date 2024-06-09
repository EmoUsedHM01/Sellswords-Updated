::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_terrifying_visage", function ( q ) {

	q.onUpdate = @( __original ) function ( _properties )
	{
		_properties.Threat += 20;
	};
});
