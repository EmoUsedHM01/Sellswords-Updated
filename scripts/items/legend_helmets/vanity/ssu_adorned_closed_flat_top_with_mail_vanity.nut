this.ssu_adorned_closed_flat_top_with_mail_vanity <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Vanity;
		this.m.ID = "armor.head.ssu_adorned_closed_flat_top_with_mail_vanity";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_adorned_closed_flat_top_with_mail_vanity.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_adorned_closed_flat_top_with_mail_vanity.Description;
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 100;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = 0;
		this.m.Vision = 0;
		this.m.HideHair = false;
		this.m.HideBeard = false;
		this.m.ItemType = this.m.ItemType;
	}

	function updateVariant()
	{
		this.m.Sprite = "ssu_bust_helmet_238";
		this.m.SpriteDamaged = "ssu_bust_helmet_238_damaged";
		this.m.SpriteCorpse = "ssu_bust_helmet_238_dead";
		this.m.Icon = "helmets/ssu_inventory_helmet_238.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

});

