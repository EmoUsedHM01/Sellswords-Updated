::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_smackdown", function ( q ) {

	q.onUpdate = @( __original ) function ( _properties )
	{
		local actor = this.getContainer().getActor();
		local weapon = actor.getMainhandItem();
		local bonus;
		if (weapon != null)
		{
			if (weapon.isItemType(this.Const.Items.ItemType.TwoHanded))
				bonus = 0.3;
			else
				bonus = 0.2;

			_properties.DamageArmorMult += bonus;
		}
		else
		{
			_properties.DamageArmorMult += 0.2;
		}
	}

});