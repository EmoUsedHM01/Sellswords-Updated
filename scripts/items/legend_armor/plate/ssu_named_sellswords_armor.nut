this.ssu_named_sellswords_armor <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {
		Potential = {
			Condition = { min = 240, max = 260 },
			StaminaModifier = { min = 26, max = 24 }
		}
	},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.ID = "armor.body.ssu_named_sellswords_armor";
		this.m.NameList = [
			"Mercenary Coat",
			"Sellsword\'s Hide",
			"Layered Armor",
			"Plated Coat"
		];
		this.m.Description = ::Mod_Sellswords.Strings.ssu_named_sellswords_armor.Description;
		this.m.ArmorDescription = "This piece of layered armor belonged to a famed mercenary once. Its high resilience and flexibility make it a remarkable piece of craftsmanship. And it even comes with extra pockets!";
		this.m.Variant = 101;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 13000;
		this.randomizeValues();
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "ssu_bust_named_sellswords_armor";
		this.m.SpriteDamagedBack = "ssu_bust_named_sellswords_armor_damaged";
		this.m.SpriteCorpseBack = "ssu_bust_named_sellswords_armor_dead";
		this.m.Icon = "legend_armor/ssu_icon_named_sellswords_armor.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/ssu_icon_named_sellswords_armor.png";
		this.m.OverlayIconLarge = "legend_armor/ssu_inventory_named_sellswords_armor.png";		
	}

});