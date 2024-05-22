::mods_hookExactClass("skills/perks/perk_ptr_iron_sights", function ( o )
{
	o.onUpdate = function ( _properties )
	{
		local weapon = this.getContainer().getActor().getMainhandItem();

		if (weapon != null && (weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow) || weapon.isWeaponType(this.Const.Items.WeaponType.Firearm)))
		{
			_properties.HitChance[this.Const.BodyPart.Head] += this.m.Bonus;
		}
	};
});