this.ssu_named_steppe_helmet_with_mail <- this.inherit("scripts/items/legend_helmets/legend_named_helmet_upgrade", {
	m = {
		Potential = {
			Condition = { min = 140, max = 150 },
			StaminaModifier = { min = 7, max = 5 },
			Vision = { min = 1, max = 1 }
		}
	},
	function create()
	{
		this.legend_named_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Helm;
		this.m.ID = "armor.head.ssu_named_steppe_helmet_with_mail";
		this.m.NameList = [
			"Steppe Helmet",
			"Decorated Nasal Helmet",
			"Headdress Helmet",
			"Horsehair Helmet"
		];
		this.m.Description = ::Mod_Sellswords.Strings.ssu_named_steppe_helmet_with_mail.Description;
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();		
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 3000;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.Sprite = "ssu_bust_helmet_204";
		this.m.SpriteDamaged = "ssu_bust_helmet_204_damaged";
		this.m.SpriteCorpse = "ssu_bust_helmet_204_dead";
		this.m.Icon = "helmets/ssu_inventory_helmet_204.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

});

