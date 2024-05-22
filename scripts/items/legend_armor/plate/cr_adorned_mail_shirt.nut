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
			1
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
		this.m.SpriteBack = "bust_body_cr51";
		this.m.SpriteDamagedBack = "bust_body_cr51_damaged";
		this.m.SpriteCorpseBack = "bust_body_cr51_dead";
		this.m.Icon = "armor/icon_body_armor_cr51.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor/icon_body_armor_cr51.png";
		this.m.OverlayIconLarge = "armor/inventory_body_armor_cr51.png";		
	}	

});

