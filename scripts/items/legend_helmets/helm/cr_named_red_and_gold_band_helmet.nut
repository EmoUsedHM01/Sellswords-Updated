this.cr_named_red_and_gold_band_helmet <- this.inherit("scripts/items/legend_helmets/legend_named_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Helm;
		this.m.ID = "armor.head.cr_named_red_and_gold_band_helmet";
		this.m.NameList = [
			"Splinted Helmet",
			"Segmented Helmet",
			"Crown of the Sand King",
			"Blazing Dome",
			"Nomad\'s Crown",
			"Splinted Feathered Helmet"
		];
		this.m.Description = "This southern style helmet is not only richly decorated, but also well balanced and made from extremely high quality metals.";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();		
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 4500;
		this.m.Condition = 165;
		this.m.ConditionMax = 165;
		this.m.StaminaModifier = -10;
		this.m.Vision = -2;
		this.m.IsLowerVanity = false;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_helmet_cr71";
		this.m.SpriteDamaged = "bust_helmet_cr71_damaged";
		this.m.SpriteCorpse = "bust_helmet_cr71_dead";
		this.m.Icon = "helmets/inventory_helmet_cr71.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

	function randomizeValues()
	{
		this.m.Vision = -2;
		this.m.StaminaModifier = this.Math.rand(12, 14) * -1;
		this.m.Condition = this.Math.rand(235, 250);
		this.m.ConditionMax = this.m.Condition;
	}

});

