this.cr_named_sellswords_armor <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;		
		this.m.ID = "armor.body.cr_named_sellswords_armor";	
		this.m.NameList = [
			"Mercenary Coat",
			"Sellsword\'s Hide",
			"Layered Armor",
			"Plated Coat"
		];
		this.m.Description = "This piece of layered armor belonged to a famed mercenary once. Its high resilience and flexibility make it a remarkable piece of craftsmanship. And it even comes with extra pockets!";
		this.m.ArmorDescription = "This piece of layered armor belonged to a famed mercenary once. Its high resilience and flexibility make it a remarkable piece of craftsmanship. And it even comes with extra pockets!";
		this.m.Variant = 101;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 13000;
		this.m.Condition = 130;
		this.m.ConditionMax = 130;
		this.m.StaminaModifier = -14;
		this.randomizeValues();
	}
	
	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "bust_body_cr101";
		this.m.SpriteDamagedBack = "bust_body_cr101_damaged";
		this.m.SpriteCorpseBack = "bust_body_cr101_dead";
		this.m.Icon = "armor/icon_body_armor_cr101.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor/icon_body_armor_cr101.png";
		this.m.OverlayIconLarge = "armor/inventory_body_armor_cr101.png";		
	}

	function randomizeValues()
	{
		this.m.StaminaModifier = this.Math.rand(24, 26) * -1;
		this.m.Condition = this.Math.rand(240, 260);
		this.m.ConditionMax = this.m.Condition;
	}	

});

