::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_blend_in", function ( q ) {

	q.onUpdate = @( __original ) function( _properties )
	{
		__original(_properties);
		_properties.TargetAttractionMult *= 5.0;
	}

});
