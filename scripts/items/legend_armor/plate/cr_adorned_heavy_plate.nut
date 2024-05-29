this.cr_adorned_heavy_plate <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.ID = "legend_armor.body.cr_adorned_heavy_plate";
		this.m.Name = "Adorned Heavy Plate";
		this.m.Description = "A heavy chainmail hauberk worn under a thick riveted jacket and reinforced with vambraces. Adorned with trophies and lovingly maintained despite its extensive use, this is the armor of a true questing knight.";
		this.m.ArmorDescription = "Includes a heavy chainmail hauberk worn under a thick riveted jacket and reinforced with vambraces. Adorned with trophies and lovingly maintained despite its extensive use, this is the armor of a true questing knight.";
		this.m.Variants = [
			0
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 3500;
		this.m.Condition = 150;
		this.m.ConditionMax = 150;
		this.m.StaminaModifier = -20;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "bust_cr_adorned_heavy_plate" + "_" + variant;
		this.m.SpriteDamagedBack = "bust_cr_adorned_heavy_plate" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "bust_cr_adorned_heavy_plate" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_cr_adorned_heavy_plate" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_cr_adorned_heavy_plate" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_cr_adorned_heavy_plate" + "_" + variant + ".png";
	}

});