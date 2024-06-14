this.quiver_of_bleeding_arrows <- this.inherit("scripts/items/ammo/ammo", {
	m = {},
	function create()
	{
		this.m.ID = "ammo.bleed_arrows";
		this.m.Name = "Quiver of Serrated Arrows";
		this.m.Description = "A quiver of arrows, with arrowheads made of sharp serrated metal.\nIt will cause targets to gain a stacking bleed debuff, causing 10 damage per stack for 2 turns.\nEach ammo refilled costs thrice as much compared to conventional ammunition.\nIs automatically refilled after each battle if you have enough ammunition.";
		this.m.Icon = "ammo/quiver_bleed.png";
		this.m.IconEmpty = "ammo/quiver_bleed_empty.png";
		this.m.SlotType = this.Const.ItemSlot.Ammo;
		this.m.ItemType = this.Const.Items.ItemType.Ammo;
		this.m.AmmoType = this.Const.Items.AmmoType.Arrows;
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
				text = "Contains [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Ammo + "[/color] arrows"
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

