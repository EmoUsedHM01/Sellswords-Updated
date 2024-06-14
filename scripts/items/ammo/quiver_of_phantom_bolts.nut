this.quiver_of_phantom_bolts <- this.inherit("scripts/items/ammo/ammo", {
	m = {},
	function create()
	{
		this.m.ID = "ammo.bolts";
		this.m.Name = "Quiver of Phantom Bolts";
		this.m.Description = "A quiver of quietly humming ghostly bolts. You can't see these translucent bolts clearly, with them constantly flickering in and out of your vision as you gaze upon them. What you can clearly see however is the power that they contain.\nFires 2 additional phantom bolts, their damage is based on how many consecutive hits you've performed.\nEach ammo refilled costs thrice as much compared to conventional ammunition.\nIs automatically refilled after each battle if you have enough ammunition.";
		this.m.Icon = "ammo/quiver_phantombolts.png";
		this.m.IconEmpty = "ammo/quiver_phantombolts_empty.png";
		this.m.SlotType = this.Const.ItemSlot.Ammo;
		this.m.ItemType = this.Const.Items.ItemType.Ammo;
		this.m.AmmoType = this.Const.Items.AmmoType.Bolts;
		this.m.ShowOnCharacter = true;
		this.m.ShowQuiver = true;
		this.m.Sprite = "bust_quiver_01";
		this.m.Value = 4500;
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

	function onEquip()
	{
		this.ammo.onEquip();
		this.getContainer().getActor().getSkills().add(this.new("scripts/skills/effects/phantom_strike_effect"));
	}

	function onUnequip()
	{
		this.ammo.onUnequip();
		this.getContainer().getActor().getSkills().removeByID("effects.phantom_strike");
	}

});