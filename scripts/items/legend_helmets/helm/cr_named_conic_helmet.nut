this.cr_named_conic_helmet <- this.inherit("scripts/items/legend_helmets/legend_named_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Helm;
		this.m.ID = "armor.head.cr_named_conic_helmet";
		this.m.NameList = [
			"Conic Feathered Helmet",
			"Iron Mask",
			"Warlord\'s Helm",
			"Iron Visage",
			"Steel Countenance"
		];
		this.m.Description = "This conic helmet has often an attached faceguard attached and finely fitted scales to protect the neck.";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();		
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 5000;
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
		this.m.Sprite = "bust_helmet_cr73";
		this.m.SpriteDamaged = "bust_helmet_cr73_damaged";
		this.m.SpriteCorpse = "bust_helmet_cr73_dead";
		this.m.Icon = "helmets/inventory_helmet_cr73.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

	function randomizeValues()
	{
		this.m.Vision = -2;
		this.m.StaminaModifier = this.Math.rand(14, 16) * -1;
		this.m.Condition = this.Math.rand(250, 270);
		this.m.ConditionMax = this.m.Condition;
	}

});

