::mods_hookExactClass("skills/effects/legend_marked_target", function ( o )
{
	o.onUpdate = function ( _properties )
	{
		_properties.RangedDefense -= 20;
		_properties.MeleeDefense -= 10;
	};
});