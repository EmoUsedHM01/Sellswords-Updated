this.cr_horn_tabard <- this.inherit("scripts/items/legend_armor/legend_armor_tabard", {
	function create()
	{
		this.legend_armor_tabard.create();
		this.m.ID = "legend_armor.body.cr_horn_tabard";
		this.m.Name = "Horn Plate";
		this.m.Description = "These segments of horn plate are made from one of the hardest yet flexible materials nature has to offer. Worn over common armor, they can help to deflect incoming blows.";
		this.m.ArmorDescription = "Segments of horn plate provide additional protection.";
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Variant = 22;
		this.updateVariant();
		this.m.Value = 4000;
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
		this.m.StaminaModifier = -4;
		this.m.Bravery = 5;
		this.m.ItemType = this.m.ItemType;
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		this.onArmorTooltip(result);
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces any melee damage to the body by [color=%negative%]-10%[/color]"
		});
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_hitInfo.BodyPart == this.Const.BodyPart.Body)
		{
			_properties.DamageReceivedMeleeMult *= 0.9;
		}
	}
	
	function updateVariant()
	{
		this.m.SpriteBack = "upgrade_22_back";
		this.m.SpriteDamagedBack = "upgrade_22_back_damaged";
		this.m.SpriteCorpseBack = "upgrade_22_back_dead";
		this.m.Icon = "armor_upgrades/icon_upgrade_22.png";
		this.m.IconLarge = "armor_upgrades/inventory_upgrade_22.png";
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.IconLarge;
	}

});

