this.cr_named_steppe_helmet_with_mail <- this.inherit("scripts/items/legend_helmets/legend_named_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Helm;
		this.m.ID = "armor.head.cr_named_steppe_helmet_with_mail";
		this.m.NameList = [
			"Steppe Helmet",
			"Decorated Nasal Helmet",
			"Headdress Helmet",
			"Horsehair Helmet"
		];
		this.m.Description = "A masterfully crafted helmet in the fashion of the steppe folks. Decorated with gold applications and equipped with additional cheek guards.";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();		
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 3000;
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
		this.m.Sprite = "bust_helmet_cr204";
		this.m.SpriteDamaged = "bust_helmet_cr204_damaged";
		this.m.SpriteCorpse = "bust_helmet_cr204_dead";
		this.m.Icon = "helmets/inventory_helmet_cr204.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

	function randomizeValues()
	{
		this.m.Vision = -1;
		this.m.StaminaModifier = this.Math.rand(5, 7) * -1;
		this.m.Condition = this.Math.rand(140, 150);
		this.m.ConditionMax = this.m.Condition;
	}

});

