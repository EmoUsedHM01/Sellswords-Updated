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
			1
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
		this.m.SpriteBack = "bust_body_cr53";
		this.m.SpriteDamagedBack = "bust_body_cr53_damaged";
		this.m.SpriteCorpseBack = "bust_body_cr53_dead";
		this.m.Icon = "armor/icon_body_armor_cr53.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor/icon_body_armor_cr53.png";
		this.m.OverlayIconLarge = "armor/inventory_body_armor_cr53.png";		
	}	

});

