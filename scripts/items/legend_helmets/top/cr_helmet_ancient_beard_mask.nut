this.cr_helmet_ancient_beard_mask <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Top;
		this.m.ID = "armor.head.cr_helmet_ancient_beard_mask";
		this.m.Name = "Ancient Bearded Mask";
		this.m.Description = "Bearded Mask of an ancient honor guard.";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [
			1
		];	
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];		
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 400;
		this.m.Condition = 50;
		this.m.ConditionMax = 50;
		this.m.StaminaModifier = -3;
		this.m.Vision = -2;
		this.m.IsLowerVanity = false;
		this.m.HideHair = false;
		this.m.HideBeard = true;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_ancient_beard_mask" + "_" + variant;
		this.m.SpriteDamaged = "legendhelms_ancient_beard_mask" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_ancient_beard_mask" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_ancient_beard_mask" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

});

