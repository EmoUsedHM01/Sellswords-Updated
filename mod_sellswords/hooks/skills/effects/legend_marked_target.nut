::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_marked_target", function ( q ) {

	q.onUpdate = @(__original) function( _properties )
	{
		_properties.RangedDefense -= 20;
		_properties.MeleeDefense -= 10;
	}
});
