this.cr_named_nordic_helmet <- this.inherit("scripts/items/legend_helmets/legend_named_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Helm;
		this.m.ID = "armor.head.cr_named_nordic_helmet";
		this.m.NameList = [
			"Sea Raider Helmet",
			"Owl Helmet",
			"Decorated Nordic Helmet",
			"Chieftain Helmet",
			"Engraved Nordic Helmet",
			"Nordic Noble Helmet"
		];
		this.m.Description = "This nordic helmet with faceguard is extraordinarly crafted, and as protective as it is impressive looking.";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();		
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 4000;
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
		this.m.Sprite = "bust_helmet_cr206";
		this.m.SpriteDamaged = "bust_helmet_cr206_damaged";
		this.m.SpriteCorpse = "bust_helmet_cr206_dead";
		this.m.Icon = "helmets/inventory_helmet_cr206.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

	function randomizeValues()
	{
		this.m.Vision = -2;
		this.m.StaminaModifier = this.Math.rand(10, 12) * -1;
		this.m.Condition = this.Math.rand(200, 225);
		this.m.ConditionMax = this.m.Condition;
	}

});

