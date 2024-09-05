this.necro_lorekeeper_body <- ::inherit("scripts/items/legend_armor/legend_armor_cloak", {
	m = {},
	function create()
	{
		this.legend_armor_cloak.create();
		this.m.ID = "legend_armor.cloak.necro_lorekeeper";
		this.m.Name = "Lorekeeper\'s Shawl";
		this.m.Description = "An ancient, but well-crafted, shawl with intricate decorations. This ceremonial cloak was required to be worn at all times by the acting head librarian.";
		this.m.ArmorDescription = "A ancient cloak offers extra protection";
		this.m.SpriteBack = "bust_body_skeleton_80";
		this.m.SpriteDamagedBack = this.m.SpriteBack + "_damaged";
		this.m.SpriteCorpseBack = this.m.SpriteBack + "_dead";
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Icon = "legend_armor/icon_ancient_lich_attire.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = "legend_armor/inventory_ancient_lich_attire.png";
		this.m.Value = 5000;
		this.m.Condition = 55;
		this.m.ConditionMax = 55;
		this.m.StaminaModifier = 0;
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Legendary;
		this.m.Bravery = 10;
	}

	function getTooltip()
	{
		local result = this.legend_armor_cloak.getTooltip();
		this.onArmorTooltip(result);
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.extend([
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
				text = "Grants immunity to being stunned"
			}
		]);
		return _result;
	}

	function onUpdateProperties( _properties )
	{
		this.legend_armor_cloak.onUpdateProperties(_properties);
		_properties.IsImmuneToStun = true;
		_properties.TargetAttractionMult *= 1.2;
	}
	
	function updateVariant()
	{
	}

});