this.cr_adorned_warriors_plate <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.ID = "legend_armor.body.cr_adorned_warriors_plate";
		this.m.Name = "Adorned Warrior\'s Plate";
		this.m.Description = "A long mail shirt covered by a riveted leather gambeson. Heavily worn from extensive use, but adorned with relics and well-maintained.";
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
		this.m.SpriteBack = "bust_cr_adorned_warriors_plate" + "_" + variant;
		this.m.SpriteDamagedBack = "bust_cr_adorned_warriors_plate" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "bust_cr_adorned_warriors_plate" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_cr_adorned_warriors_plate" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_cr_adorned_warriors_plate" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_cr_adorned_warriors_plate" + "_" + variant + ".png";
	}

});