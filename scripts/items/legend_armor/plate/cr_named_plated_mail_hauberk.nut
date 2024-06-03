this.cr_named_plated_mail_hauberk <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.ID = "armor.body.cr_named_plated_mail_hauberk";
		this.m.NameList = [
			"Harness",
			"Ward",
			"Defense",
			"Barrier",
			"Plate Armor",
			"Plated Vest",
			"Lifesaver"
		];
		this.m.Description = "A thick mail hauberk combined with sturdy metal plates. This armor will protect its wearer even in the fiercest of battles.";
		this.m.ArmorDescription = "A thick mail hauberk combined with sturdy metal plates. This armor will protect its wearer even in the fiercest of battles.";
		this.m.Variant = 36;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 14000;
		this.m.Condition = 130;
		this.m.ConditionMax = 130;
		this.m.StaminaModifier = -14;
		this.randomizeValues();
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "bust_cr_named_plated_mail_hauberk";
		this.m.SpriteDamagedBack = "bust_cr_named_plated_mail_hauberk_damaged";
		this.m.SpriteCorpseBack = "bust_cr_named_plated_mail_hauberk_dead";
		this.m.Icon = "legend_armor/icon_cr_named_plated_mail_hauberk.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_cr_named_plated_mail_hauberk.png";
		this.m.OverlayIconLarge = "legend_armor/inventory_cr_named_plated_mail_hauberk.png";		
	}

	function randomizeValues()
	{
		this.m.StaminaModifier = this.Math.rand(26, 28) * -1;
		this.m.Condition = this.Math.rand(250, 265);
		this.m.ConditionMax = this.m.Condition;
	}

});