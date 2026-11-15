this.ssu_helmet_orc_bear_head_helm <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Helm;
		this.m.ID = "armor.head.ssu_helmet_orc_bear_head_helm";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_helmet_orc_bear_head_helm_helm.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_helmet_orc_bear_head_helm_helm.Description;
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 400;
		this.m.Condition = 115;
		this.m.ConditionMax = 115;
		this.m.StaminaModifier = -12;
		this.m.Vision = -1;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.ItemType = this.m.ItemType;
	}

	function updateVariant()
	{
		this.m.Sprite = "ssu_bust_greenskin_11_helmet_01";
		this.m.SpriteDamaged = "ssu_bust_greenskin_11_helmet_01_damaged";
		this.m.SpriteCorpse = "ssu_bust_greenskin_11_helmet_01_dead";
		this.m.Icon = "helmets/ssu_inventory_helmet_73.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

});

