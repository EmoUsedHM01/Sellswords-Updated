this.acid_flask_item_02 <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.acid_flask_02";
		this.m.Name = "Stollwurm's Acid Flask";
		this.m.Description = "A flask filled with the concentrate of a Stollwurm\'s acidic blood. It is highly corrosive to many materials and burns through armor quickly and is more robust than normal acid flasks. Can be thrown at short ranges. If the company has Alchemy Tools, this item is refilled after each battle, consuming 30 ammunition per use.";
		this.m.IconLarge = "tools/acid_flask_02.png";
		this.m.Icon = "tools/acid_flask_02_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Tool;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_acid_flask_02";
		this.m.Value = 3400;
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		this.m.AmmoCost = 30;
		this.m.RangeMax = 3;
		this.m.StaminaModifier = 0;
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

		result.extend([
		{
			id = 66,
			type = "text",
			text = this.getValueString()
		},
		{
			id = 64,
			type = "text",
			text = "Worn in Offhand"
		},
		{
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Range of [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RangeMax + "[/color] tiles"
		},
		{
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces the target\'s armor by [color=" + this.Const.UI.Color.DamageValue + "]25%[/color] each turn for 3 turns"
		},
		{
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=" + this.Const.UI.Color.DamageValue + "]33%[/color] chance to hit bystanders at the same or lower height level as well"
		},
		{
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Lasts for at least [color=" + this.Const.UI.Color.PositiveValue + "]" + 2 + "[/color] turns"
		}]);
		if (!this.World.Retinue.hasFollower("follower.alchemist"))
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Cannot be refilled after battle, because this company has no Alchemy Tools"
			});
		}
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function isAmountShown()
	{
		return true;
	}

	function getAmountString()
	{
		return this.m.Ammo + "/" + this.m.AmmoMax;
	}

	function setAmmo( _a )
	{
		this.weapon.setAmmo( _a );

		if (this.m.Ammo > 0)
		{
			this.m.Name = "Acid Flask";
			this.m.IconLarge = "tools/acid_flask_02.png";
			this.m.Icon = "tools/acid_flask_02_70x70.png";
			this.m.ShowArmamentIcon = true;
		}
		else
		{
			this.m.Name = "Stollwurm's Acid Flask (Used)";
			this.m.IconLarge = "tools/acid_flask_02.png";
			this.m.Icon = "tools/acid_flask_02_70x70.png";
			this.m.ShowArmamentIcon = false;
		}

		this.updateAppearance();
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local skill = this.new("scripts/skills/actives/throw_acid_flask_02");
		skill.setItem(this);
		this.addSkill(skill);
	}

});