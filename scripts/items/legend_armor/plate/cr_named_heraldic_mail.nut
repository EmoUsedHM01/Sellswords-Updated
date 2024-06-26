this.cr_named_heraldic_mail <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.ID = "armor.body.cr_named_heraldic_mail";
		this.m.NameList = [
			"Heraldic Plate",
			"Splendor",
			"Grandiosity",
			"Pageantry",
			"Swank",
			"Duty",
			"Honor",
			"Noble Plate"
		];
		this.m.Description = "Truly fit for a knight, this plate coat is made from the highest quality materials and boasts precious decorations and ornaments.";
		this.m.ArmorDescription = "Truly fit for a knight, this plate coat is made from the highest quality materials and boasts precious decorations and ornaments.";
		this.m.Variant = 36;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 12500;
		this.m.Condition = 130;
		this.m.ConditionMax = 130;
		this.m.StaminaModifier = -14;
		this.randomizeValues();
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "bust_cr_named_heraldic_mail";
		this.m.SpriteDamagedBack = "bust_cr_named_heraldic_mail_damaged";
		this.m.SpriteCorpseBack = "bust_cr_named_heraldic_mail_dead";
		this.m.Icon = "legend_armor/icon_cr_named_heraldic_mail.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_cr_named_heraldic_mail.png";
		this.m.OverlayIconLarge = "legend_armor/inventory_cr_named_heraldic_mail.png";
	}

	function randomizeValues()
	{
		this.m.StaminaModifier = this.Math.rand(22, 24) * -1;
		this.m.Condition = this.Math.rand(225, 245);
		this.m.ConditionMax = this.m.Condition;
	}

});