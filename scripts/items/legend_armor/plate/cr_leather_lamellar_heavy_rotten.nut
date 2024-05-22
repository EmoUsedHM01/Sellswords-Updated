this.cr_leather_lamellar_heavy_rotten <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.ID = "legend_armor.body.cr_leather_lamellar_heavy_rotten";
		this.m.Name = "Decayed Heavy Lamellar Armor";
		this.m.Description = "A heavy lamellar armor that covers most parts of the body with thick that is worn and decayed.";
		this.m.ArmorDescription = "Includes a heavy lamellar armor of decaying plated steel.";
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 2250;
		this.m.Condition = 170;
		this.m.ConditionMax = 170;
		this.m.StaminaModifier = -30;
	}
	
	function updateVariant()
	{
		this.m.SpriteBack = "bust_body_cr61";
		this.m.SpriteDamagedBack = "bust_body_cr61_damaged";
		this.m.SpriteCorpseBack = "bust_body_cr61_dead";
		this.m.Icon = "armor/icon_body_armor_cr61.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor/icon_body_armor_cr61.png";
		this.m.OverlayIconLarge = "armor/inventory_body_armor_cr61.png";		
	}	

});

