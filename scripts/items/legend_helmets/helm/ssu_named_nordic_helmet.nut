this.ssu_named_nordic_helmet <- this.inherit("scripts/items/legend_helmets/legend_named_helmet_upgrade", {
	m = {
		Potential = {
			Condition = { min = 200, max = 225 },
			StaminaModifier = { min = 12, max = 10 },
			Vision = { min = 2, max = 2 }
		}
	},
	function create()
	{
		this.legend_named_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Helm;
		this.m.ID = "armor.head.ssu_named_nordic_helmet";
		this.m.NameList = [
			"Sea Raider Helmet",
			"Owl Helmet",
			"Decorated Nordic Helmet",
			"Chieftain Helmet",
			"Engraved Nordic Helmet",
			"Nordic Noble Helmet"
		];
		this.m.Description = ::Mod_Sellswords.Strings.ssu_named_nordic_helmet.Description;
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();		
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 4000;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.Sprite = "ssu_bust_helmet_206";
		this.m.SpriteDamaged = "ssu_bust_helmet_206_damaged";
		this.m.SpriteCorpse = "ssu_bust_helmet_206_dead";
		this.m.Icon = "helmets/ssu_inventory_helmet_206.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

});

