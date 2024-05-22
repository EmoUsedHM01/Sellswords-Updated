::mods_hookExactClass("skills/perks/perk_sundering_strikes", function ( o )
{
	o.onUpdate = function ( _properties )
	{
		local actor = this.getContainer().getActor();
		local weapon = actor.getMainhandItem();
		local bonus;
		//if (weapon != null && !_skill.isRanged() && weapon.isItemType(this.Const.Items.ItemType.TwoHanded))			
		if (weapon != null)			
		{
			if (weapon.isItemType(this.Const.Items.ItemType.TwoHanded))
			{
				bonus = 0.3;
			}
			else
			{
				bonus = 0.2;
			}
			_properties.DamageArmorMult += bonus;
		}
		else
		{
			_properties.DamageArmorMult += 0.2;
		}
	};
});