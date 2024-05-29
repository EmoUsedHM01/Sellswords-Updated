::mods_hookExactClass("skills/perks/perk_legend_specialist_hammer_skill", function ( o )
{
	o.onUpdate = function ( _properties )
	{
		local dc = 0;
		local actor = this.getContainer().getActor();
		if (actor.isPlayerControlled())
		{
			dc = this.getContainer().getActor().getDaysWithCompany();
		}
	
		dc = this.Math.floor(dc/7);
		dc = 0.01 * this.Math.min(5 * dc + 25, 100);
		local item = this.getContainer().getActor().getMainhandItem();
		if (item != null)
		{
			if (item.getID() == "weapon.legend_hammer" || item.getID() == "weapon.legend_named_blacksmith_hammer")
			{
				_properties.MeleeSkill += 12;
				_properties.DamageArmorMult += 0.4;
			}
			else if (item.isItemType(this.Const.Items.ItemType.OneHanded) && item.isWeaponType(this.Const.Items.WeaponType.Hammer))
			{
				_properties.MeleeSkill += (12 * dc);
				_properties.DamageArmorMult += (0.4 * dc);
			}
		}
	}

	o.getUnactivatedPerkTooltipHints <- function()
	{
		/*
		local dc = 0;
		local actor = this.getContainer().getActor();
		if (::MSU.isKindOf(actor, "player"))
		{
			dc = this.getContainer().getActor().getDaysWithCompany();
		}

		dc = this.Math.floor(dc/7);
		dc = 0.01 * this.Math.min(5 * dc + 25, 100); */

		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = this.format("This character has accrued a banana for other weapons")
			}
		];
		return ret;
	}

});	