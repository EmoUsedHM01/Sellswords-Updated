this.ssu_necro_lorekeeper_body <- ::inherit("scripts/items/legend_armor/legend_armor_cloak", {
	m = {},
	function create()
	{
		this.legend_armor_cloak.create();
		this.m.ID = "legend_armor.cloak.ssu_necro_lorekeeper";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_necro_lorekeeper_body.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_necro_lorekeeper_body.Description;
		this.m.ArmorDescription = "A ancient cloak offers extra protection";
		this.m.SpriteBack = "bust_body_skeleton_80";
		this.m.SpriteDamagedBack = this.m.SpriteBack + "_damaged";
		this.m.SpriteCorpseBack = this.m.SpriteBack + "_dead";
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Icon = "legend_armor/ssu_icon_ancient_lich_attire.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = "legend_armor/ssu_inventory_ancient_lich_attire.png";
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
				text = ::Mod_Sellswords.Strings.ssu_necro_lorekeeper_body.Tooltip1
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.ssu_necro_lorekeeper_body.Tooltip2
			}
		]);
		return _result;
	}

	function onUpdateProperties( _properties )
	{
		this.legend_armor_cloak.onUpdateProperties(_properties);
		_properties.IsImmuneToStun = true;
		_properties.AggroMult *= 1.2;
	}
	
	function updateVariant()
	{
	}

});