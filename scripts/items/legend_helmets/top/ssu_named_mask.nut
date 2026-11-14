this.ssu_named_mask <- this.inherit("scripts/items/legend_helmets/legend_named_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Top;
		this.m.ID = "armor.head.ssu_named_mask";
		this.m.NameList = [
			"Conic Feathered Helmet",
			"Iron Mask",
			"Warlord\'s Helm",
			"Iron Visage",
			"Steel Countenance"
		];
		this.m.Description = ::Mod_Sellswords.Strings.ssu_named_mask.Description;
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 800;
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
		this.m.StaminaModifier = -4;
		this.m.Vision = -1;
		this.m.IsLowerVanity = false;
		this.m.HideHair = false;
		this.m.HideBeard = true;
		this.m.ItemType = this.m.ItemType;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.Sprite = "ssu_bust_helmet_74";
		this.m.SpriteDamaged = "ssu_bust_helmet_74_damaged";
		this.m.SpriteCorpse = "ssu_bust_helmet_74_dead";
		this.m.Icon = "helmets/ssu_inventory_helmet_74.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

	function randomizeValues()
	{
		this.m.Vision = this.Math.rand(2, 2) * -1;
		this.m.StaminaModifier = this.Math.rand(1, 1) * -1;
		this.m.Condition = this.Math.rand(40, 50);
		this.m.ConditionMax = this.m.Condition;
	}

});

