::mods_hookExactClass("skills/perks/perk_slaughterer", function ( o )
{
	local ws_onUpdate = o.onUpdate;
	o.onUpdate = function ( _properties )
	{
		ws_onUpdate(_properties);
		_properties.FlatOnKillOtherActorModifier -= 10;
	}
});	