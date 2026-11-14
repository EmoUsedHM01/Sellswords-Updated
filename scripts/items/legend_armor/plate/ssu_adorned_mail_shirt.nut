this.ssu_adorned_mail_shirt <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.ID = "legend_armor.body.ssu_adorned_mail_shirt";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_adorned_mail_shirt.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_adorned_mail_shirt.Description;
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
		this.m.SpriteBack = "ssu_bust_adorned_mail_shirt" + "_" + variant;
		this.m.SpriteDamagedBack = "ssu_bust_adorned_mail_shirt" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "ssu_bust_adorned_mail_shirt" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/ssu_icon_adorned_mail_shirt" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/ssu_icon_adorned_mail_shirt" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/ssu_inventory_adorned_mail_shirt" + "_" + variant + ".png";
	}

});