this.necro_lorekeeper_head <- ::inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.Type = ::Const.Items.HelmetUpgrades.Vanity;
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Legendary;
		this.m.ID = "armor.head.necro_lorekeeper";
		this.m.Name = "Lorekeeper\'s Headpiece";
		this.m.Description = "An ancient, but well-crafted, headpiece with intricate decorations. This ceremonial headdress was required to be worn at all times by the acting head librarian.";
		this.m.ArmorDescription = "A Headpiece from ancient time offers both physical and mental protection.";
		this.m.Sprite = "bust_helmet_skeleton_82";
		this.m.SpriteDamaged = this.m.Sprite + "_damaged";
		this.m.SpriteCorpse = this.m.Sprite + "_dead";
		this.m.Icon = "legend_helmets/inventory_ancient_lich_headpiece.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 5000;
		this.m.Condition = 35;
		this.m.ConditionMax = 35;
		this.m.StaminaModifier = 0;
		this.m.Vision = 0;
		this.m.HideHair = true;
	}

	function getTooltip()
	{
		local result = this.legend_helmet_upgrade.getTooltip();
		this.onArmorTooltip(result);
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Allows the wearer to see at night and negates any penalties due to nighttime."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "Makes enemies more likely to attack you"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Doubles your Resolve if defending against fear and mind control abilities"
			}
		]);

		return _result;
	}

	function onUpdateProperties(_properties)
	{
		this.legend_helmet_upgrade.onUpdateProperties(_properties);
  		_properties.MoraleCheckBraveryMult[::Const.MoraleCheckType.MentalAttack] *= 2.0;
  		_properties.IsAffectedByNight = false;
		_properties.TargetAttractionMult *= 1.2;
	}

	function updateVariant()
	{
	}
});