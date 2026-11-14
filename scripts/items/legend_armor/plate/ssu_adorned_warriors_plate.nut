this.ssu_adorned_warriors_plate <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.ID = "legend_armor.body.ssu_adorned_warriors_plate";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_adorned_warriors_plate.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_adorned_warriors_plate.Description;
		this.m.ArmorDescription = "Includes a long mail shirt covered by a riveted leather gambeson. Heavily worn from extensive use, but adorned with relics and well-maintained.";
		this.m.Variants = [
			0
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 2500;
		this.m.Condition = 110;
		this.m.ConditionMax = 110;
		this.m.StaminaModifier = -13;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "ssu_bust_adorned_warriors_plate" + "_" + variant;
		this.m.SpriteDamagedBack = "ssu_bust_adorned_warriors_plate" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "ssu_bust_adorned_warriors_plate" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/ssu_icon_adorned_warriors_plate" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/ssu_icon_adorned_warriors_plate" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/ssu_inventory_adorned_warriors_plate" + "_" + variant + ".png";
	}

});