this.ssu_named_red_and_gold_band_helmet <- this.inherit("scripts/items/legend_helmets/legend_named_helmet_upgrade", {
	m = {
		Potential = {
			Condition = { min = 235, max = 250 },
			StaminaModifier = { min = 14, max = 12 },
			Vision = { min = 2, max = 2 }
		}
	},
	function create()
	{
		this.legend_named_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Helm;
		this.m.ID = "armor.head.ssu_named_red_and_gold_band_helmet";
		this.m.NameList = [
			"Splinted Helmet",
			"Segmented Helmet",
			"Crown of the Sand King",
			"Blazing Dome",
			"Nomad\'s Crown",
			"Splinted Feathered Helmet"
		];
		this.m.Description = ::Mod_Sellswords.Strings.ssu_named_red_and_gold_band_helmet.Description;
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();		
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 4500;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.Sprite = "ssu_bust_helmet_71";
		this.m.SpriteDamaged = "ssu_bust_helmet_71_damaged";
		this.m.SpriteCorpse = "ssu_bust_helmet_71_dead";
		this.m.Icon = "helmets/ssu_inventory_helmet_71.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

});

