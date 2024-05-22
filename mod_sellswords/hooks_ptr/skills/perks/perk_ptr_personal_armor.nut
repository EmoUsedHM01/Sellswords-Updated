::mods_hookExactClass("skills/perks/perk_ptr_personal_armor", function ( o )
{
	o.onUpdate = function ( _properties )
	{
		_properties.DamageReceivedArmorMult *= 0.95;
		_properties.ArmorMult[this.Const.BodyPart.Head] *= 1.1;
		_properties.ArmorMult[this.Const.BodyPart.Body] *= 1.1;	
	}
});	