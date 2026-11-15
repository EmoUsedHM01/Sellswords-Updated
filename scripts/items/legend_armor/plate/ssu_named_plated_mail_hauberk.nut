this.ssu_named_plated_mail_hauberk <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {
		Potential = {
			Condition = { min = 250, max = 265 },
			StaminaModifier = { min = 28, max = 26 }
		}
	},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.ID = "armor.body.ssu_named_plated_mail_hauberk";
		this.m.NameList = [
			"Harness",
			"Ward",
			"Defense",
			"Barrier",
			"Plate Armor",
			"Plated Vest",
			"Lifesaver"
		];
		this.m.Description = ::Mod_Sellswords.Strings.ssu_named_plated_mail_hauberk.Description;
		this.m.ArmorDescription = "A thick mail hauberk combined with sturdy metal plates. This armor will protect its wearer even in the fiercest of battles.";
		this.m.Variant = 36;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 14000;
		this.randomizeValues();
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "ssu_bust_named_plated_mail_hauberk";
		this.m.SpriteDamagedBack = "ssu_bust_named_plated_mail_hauberk_damaged";
		this.m.SpriteCorpseBack = "ssu_bust_named_plated_mail_hauberk_dead";
		this.m.Icon = "legend_armor/ssu_icon_named_plated_mail_hauberk.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/ssu_icon_named_plated_mail_hauberk.png";
		this.m.OverlayIconLarge = "legend_armor/ssu_inventory_named_plated_mail_hauberk.png";		
	}

});