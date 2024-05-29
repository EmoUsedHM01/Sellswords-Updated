this.cr_adorned_mail_shirt <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.ID = "legend_armor.body.cr_adorned_mail_shirt";
		this.m.Name = "Adorned Harness";
		this.m.Description = "A heavy mail shirt covered by a quilted surcoat. An impressive and well-maintained piece, adorned with trophies and holy symbols.";
		this.m.ArmorDescription = "Includes a heavy mail shirt covered by a quilted surcoat. An impressive and well-maintained piece, adorned with trophies and holy symbols.";
		this.m.Variants = [
			0
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 1150;
		this.m.Condition = 75;
		this.m.ConditionMax = 75;
		this.m.StaminaModifier = -8;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "bust_cr_adorned_mail_shirt" + "_" + variant;
		this.m.SpriteDamagedBack = "bust_cr_adorned_mail_shirt" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "bust_cr_adorned_mail_shirt" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_cr_adorned_mail_shirt" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_cr_adorned_mail_shirt" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_cr_adorned_mail_shirt" + "_" + variant + ".png";
	}

});