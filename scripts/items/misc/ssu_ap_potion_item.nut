this.ssu_ap_potion_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.m.ID = "misc.gain_ap_potion";
		this.m.Name = "Elixir of Potency";
		this.m.Description = "Few people have heard about this legendary potion, and fewer still would be capable enough to craft it.\nCreated from using the rarest of ingredients, it pushes the abilities of any who imbibe to their upmost limits.";
		this.m.Icon = "consumables/vial_red_01.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.Value = 10000;
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
		
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Gain [color=" + this.Const.UI.Color.PositiveValue + "]+1[/color] Action Point.\nPermanently."
		});
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

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
			id = 65,
			type = "text",
			text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		this.Sound.play("sounds/combat/drink_03.wav", this.Const.Sound.Volume.Inventory);
		_actor.m.BaseProperties.ActionPoints += 1;
		this.Const.Tactical.Common.checkDrugEffect(_actor);
		return true;
	}

});