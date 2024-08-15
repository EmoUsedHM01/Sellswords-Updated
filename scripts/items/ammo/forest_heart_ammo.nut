this.forest_heart_ammo <- this.inherit("scripts/items/ammo/ammo", {
	m = {},
	function create()
	{
		this.m.ID = "ammo.heart";
		this.m.Name = "Heart of the Forest";
		this.m.Description = "The life and soul of the forest, used for casting Dryad magic. Is automatically refilled after each battle if you have enough ammunition.";
		this.m.Icon = "ammo/forest_heart_ammo.png";
		this.m.IconEmpty = "ammo/forest_heart_empty.png";
		this.m.SlotType = this.Const.ItemSlot.Ammo;
		this.m.ItemType = this.Const.Items.ItemType.Ammo;
		this.m.AmmoType = this.Const.Items.AmmoType.Heart;
		this.m.ShowOnCharacter = false;
		this.m.ShowQuiver = false;
		this.m.Value = 0;
		this.m.Ammo = 3;
		this.m.AmmoMax = 3;
		this.m.AmmoCost = 5;
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
				icon = "ui/icons/special.png",
				text = "Contains enough power for [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Ammo + "[/color] uses"
			});
		}
		else
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Is dull and useless[/color]"
			});
		}

		return result;
	}

});

