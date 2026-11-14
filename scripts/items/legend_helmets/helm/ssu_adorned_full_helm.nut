this.ssu_adorned_full_helm <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Helm;
		this.m.ID = "armor.head.ssu_adorned_full_helm";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_adorned_full_helm.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_adorned_full_helm.Description;
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();		
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 3500;
		this.m.Condition = 210;
		this.m.ConditionMax = 210;
		this.m.StaminaModifier = -14;
		this.m.Vision = -2;
		this.m.IsLowerVanity = false;
		this.m.HideHair = true;
		this.m.HideBeard = true;
	}

	function updateVariant()
	{
		this.m.Sprite = "ssu_bust_helmet_239";
		this.m.SpriteDamaged = "ssu_bust_helmet_239_damaged";
		this.m.SpriteCorpse = "ssu_bust_helmet_239_dead";
		this.m.Icon = "helmets/ssu_inventory_helmet_239.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

});

