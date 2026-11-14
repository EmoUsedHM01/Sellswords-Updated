this.ssu_adorned_heavy_plate <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.ID = "legend_armor.body.ssu_adorned_heavy_plate";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_adorned_heavy_plate.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_adorned_heavy_plate.Description;
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
		this.m.SpriteBack = "ssu_bust_adorned_heavy_plate" + "_" + variant;
		this.m.SpriteDamagedBack = "ssu_bust_adorned_heavy_plate" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "ssu_bust_adorned_heavy_plate" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/ssu_icon_adorned_heavy_plate" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/ssu_icon_adorned_heavy_plate" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/ssu_inventory_adorned_heavy_plate" + "_" + variant + ".png";
	}

});