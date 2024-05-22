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
			1
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
		this.m.SpriteBack = "bust_body_cr52";
		this.m.SpriteDamagedBack = "bust_body_cr52_damaged";
		this.m.SpriteCorpseBack = "bust_body_cr52_dead";
		this.m.Icon = "armor/icon_body_armor_cr52.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor/icon_body_armor_cr52.png";
		this.m.OverlayIconLarge = "armor/inventory_body_armor_cr52.png";		
	}	

});

