this.quiver_of_poisoned_bolts <- this.inherit("scripts/items/ammo/ammo", {
	m = {},
	function create()
	{
		this.m.ID = "ammo.poison_bolts";
		this.m.Name = "Quiver of Poisoned Bolts";
		this.m.Description = "A quiver of arrows, taken from the corpse of a dead Goblin Ambusher.\nIt contains a liquid filling the bottom of the quiver to quickly apply the Goblin's poison to inserted arrows, the poison lasts for 3 turns.\nEach ammo refilled costs thrice as much compared to conventional ammunition.\nIs automatically refilled after each battle if you have enough ammunition.";
		this.m.Icon = "ammo/quiver_poisonbolts.png";
		this.m.IconEmpty = "ammo/quiver_poisonbolts_empty.png";
		this.m.SlotType = this.Const.ItemSlot.Ammo;
		this.m.ItemType = this.Const.Items.ItemType.Ammo;
		this.m.AmmoType = this.Const.Items.AmmoType.Bolts;
		this.m.ShowOnCharacter = true;
		this.m.ShowQuiver = true;
		this.m.Sprite = "bust_quiver_01";
		this.m.Value = 1500;
		this.m.Ammo = 10;
		this.m.AmmoMax = 10;
		this.m.AmmoCost = 3;
		this.m.IsDroppedAsLoot = true;
	}

	function getTooltip()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.m.Ammo != 0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Contains [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Ammo + "[/color] bolts"
			});
		}
		else
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Is empty and useless[/color]"
			});
		}

		return result;
	}

});

