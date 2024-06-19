this.quiver_of_fire_arrows <- this.inherit("scripts/items/ammo/ammo", {
	m = {},
	function create()
	{
		this.m.ID = "ammo.arrows";
		this.m.Name = "Quiver of Fire Arrows";
		this.m.Description = "A quiver of arrows with a oiled tip and a sparker on the rim.\nIt will inflict an additional 50% of damage as fire damage and ignite the ground the target stands on for 2 turns, does extra damage against undead and trees.\nCan cause fire related injuries.\nEach ammo refilled costs thrice as much compared to conventional ammunition.\nIs automatically refilled after each battle if you have enough ammunition.";
		this.m.Icon = "ammo/quiver_fire.png";
		this.m.IconEmpty = "ammo/quiver_fire_empty.png";
		this.m.SlotType = this.Const.ItemSlot.Ammo;
		this.m.ItemType = this.Const.Items.ItemType.Ammo;
		this.m.AmmoType = this.Const.Items.AmmoType.Arrows;
		this.m.ShowOnCharacter = true;
		this.m.ShowQuiver = true;
		this.m.Sprite = "bust_quiver_01";
		this.m.Value = 1500;
		this.m.Ammo = 5;
		this.m.AmmoMax = 5;
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

	function onEquip()
	{
		this.ammo.onEquip();
		this.getContainer().getActor().getSkills().add(this.new("scripts/skills/effects/flaming_arrows_effect"));
	}

	function onUnequip()
	{
		this.ammo.onUnequip();
		this.getContainer().getActor().getSkills().removeByID("effects.flaming_arrows");
	}

});