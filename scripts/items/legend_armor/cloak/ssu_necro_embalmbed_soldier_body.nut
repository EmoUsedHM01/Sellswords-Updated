this.ssu_necro_embalmbed_soldier_body <- this.inherit("scripts/items/legend_armor/legend_armor_cloak", {
	function create()
	{
		this.legend_armor_cloak.create();
		this.m.ID = "legend_armor.body.ssu_necro_embalmbed_soldier_body";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_necro_embalmbed_soldier_body.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_necro_embalmbed_soldier_body.Description;
		this.m.ArmorDescription = "An ancient piece of armor, designed to protect the torso from attacks.";
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Variant = 1;
		this.updateVariant();
		this.m.Value = 1200;
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
		this.m.StaminaModifier = -4;
		this.m.ItemType = this.m.ItemType;
	}

	function updateVariant()
	{
		this.m.SpriteBack = "mummy_royal_plate_01";
		this.m.SpriteDamagedBack = "mummy_royal_plate_01_damaged";
		this.m.SpriteCorpseBack = "mummy_royal_plate_01_dead";
		this.m.Icon = "legend_armor/ssu_necro_icon_embalmbed_soldier_body.png";
		this.m.IconLarge = "legend_armor/ssu_necro_inventory_embalmbed_soldier_body.png";
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.IconLarge;
	}

});