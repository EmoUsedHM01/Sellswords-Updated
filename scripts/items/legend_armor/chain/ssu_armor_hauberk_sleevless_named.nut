this.ssu_armor_hauberk_sleevless_named <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Chain;
		this.m.ID = "legend_armor.body.ssu_armor_hauberk_sleevless_named";
		this.m.Name = "";
		this.m.NameList = [
			"Mercenary Coat",
			"Sellsword\'s Hide",
			"Layered Armor",
			"Plated Coat"
		];
		this.m.Description = ::Mod_Sellswords.Strings.ssu_armor_hauberk_sleevless_named.Description;
		this.m.ArmorDescription = "Includes a sleevless mail hauberk made from the highest quality materials and boasts precious decorations and ornaments.";
		this.m.Variants = [
			0
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 3500;
		this.m.Condition = 120;
		this.m.ConditionMax = 120;
		this.m.StaminaModifier = -15;
		this.m.ItemType = this.m.ItemType;
		this.randomizeValues();
	}

	function randomizeValues()
	{
		this.m.StaminaModifier = this.Math.rand(8, 10) * -1;
		this.m.Condition = this.Math.rand(105, 125);
		this.m.ConditionMax = this.m.Condition;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "ssu_bust_armor_hauberk_sleevless_named" + "_" + variant;
		this.m.SpriteDamagedBack = "ssu_bust_armor_hauberk_sleevless_named" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "ssu_bust_armor_hauberk_sleevless_named" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/ssu_icon_armor_hauberk_sleevless_named" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/ssu_icon_armor_hauberk_sleevless_named" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/ssu_inventory_armor_hauberk_sleevless_named" + "_" + variant + ".png";
	}

});