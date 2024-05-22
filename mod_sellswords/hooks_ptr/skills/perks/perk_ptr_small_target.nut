::mods_hookExactClass("skills/perks/perk_ptr_small_target", function ( o )
{
	o.onUpdate = function ( _properties )
	{
		_properties.HitChanceMult[this.Const.BodyPart.Head] = 1.25;
	}
});	