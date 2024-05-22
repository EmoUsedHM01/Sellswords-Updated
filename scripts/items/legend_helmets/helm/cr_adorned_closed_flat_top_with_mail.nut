this.cr_adorned_closed_flat_top_with_mail <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Helm;
		this.m.ID = "armor.head.cr_adorned_closed_flat_top_with_mail";
		this.m.Name = "Adorned Closed Flat Top";
		this.m.Description = "A closed helmet with complete faceguard and mail to protect the neck. Heavily worn from extensive use, but adorned with relics and well-maintained.";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();		
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 3000;
		this.m.Condition = 215;
		this.m.ConditionMax = 215;
		this.m.StaminaModifier = -15;
		this.m.Vision = -2;
		this.m.IsLowerVanity = false;
		this.m.HideHair = true;
		this.m.HideBeard = true;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_helmet_cr238";
		this.m.SpriteDamaged = "bust_helmet_cr238_damaged";
		this.m.SpriteCorpse = "bust_helmet_cr238_dead";
		this.m.Icon = "helmets/inventory_helmet_cr238.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

});

