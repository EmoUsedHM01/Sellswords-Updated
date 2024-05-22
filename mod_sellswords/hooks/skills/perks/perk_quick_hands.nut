::mods_hookExactClass("skills/perks/perk_quick_hands", function ( o )
{
	local getItemActionCost = o.getItemActionCost;
	o.getItemActionCost = function ( _items )
	{
		if (this.getContainer().hasSkill("perk.quick_hands"))
		{
			return this.m.IsSpent ? null : 0;
		}

		local twoHandedItemsCount = 0;

		foreach( i in _items )
		{
			if (i == null)
			{
				continue;
			}

			if (i.isItemType(this.Const.Items.ItemType.Shield))
			{
				return null;
			}

			if (i.isItemType(this.Const.Items.ItemType.TwoHanded) && i.isItemType(this.Const.Items.ItemType.MeleeWeapon))
			{
				twoHandedItemsCount++;
			}
		}

		if (twoHandedItemsCount == 2)
		{
			return null;
		}

		return getItemActionCost(_items);
	};
});