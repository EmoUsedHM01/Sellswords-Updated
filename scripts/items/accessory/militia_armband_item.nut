this.militia_armband_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {
		ResolveBonus = 0
	},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.militia_armband";
		this.m.Name = "Militia Armband";
		this.m.Description = "A crimson armband signaling membership for militias incapable of requisitioning proper uniforms.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.IconLarge = "";
		this.m.Icon = "accessory/militia_armband.png";
		this.m.Sprite = "bust_militia_band_01";
		this.m.Value = 100;
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
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+1[/color] Resolve per ally wearing a militia armband or sergeant\'s sash."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Current bonus: [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.ResolveBonus + "[/color]"
			}
		];
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
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/cloth_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function updateResolveBonus()
	{
		this.m.ResolveBonus = 0;
		local roster = ::World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local itemAtSlot = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (itemAtSlot != null && (itemAtSlot.m.ID == "accessory.militia_armband" || itemAtSlot.m.ID == "accessory.sergeant_badge"))
				this.m.ResolveBonus += 1;
		}
	}

	function onTurnStart()
	{
		this.updateResolveBonus();
	}

	function onCombatStarted()
	{
		this.updateResolveBonus();
	}

	function onUpdateProperties( _properties )
	{
		this.accessory.onUpdateProperties(_properties);
		this.updateResolveBonus();
		_properties.Bravery += this.m.ResolveBonus;
	}

});