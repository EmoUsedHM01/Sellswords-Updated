this.cr_leather_lamellar_harness_heavy_rotten <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.ID = "legend_armor.body.cr_leather_lamellar_harness_heavy_rotten";
		this.m.Name = "Decayed Lamellar Harness";
		this.m.Description = "This lamellar harness made of thick overlapping metal plates is worn and parts have come lose or are missing. It still offers very good protection if you don\'t mind the smell.";
		this.m.ArmorDescription = "Includes worn and smelly heavy armor made of thick overlapping metal plates that cover most of the upper body.";
		this.m.Variants = [
			0
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 900;
		this.m.Condition = 90;
		this.m.ConditionMax = 90;
		this.m.StaminaModifier = -14;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "bust_cr_leather_lamellar_harness_heavy_rotten" + "_" + variant;
		this.m.SpriteDamagedBack = "bust_cr_leather_lamellar_harness_heavy_rotten" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "bust_cr_leather_lamellar_harness_heavy_rotten" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_cr_leather_lamellar_harness_heavy_rotten" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_cr_leather_lamellar_harness_heavy_rotten" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_cr_leather_lamellar_harness_heavy_rotten" + "_" + variant + ".png";
	}

});