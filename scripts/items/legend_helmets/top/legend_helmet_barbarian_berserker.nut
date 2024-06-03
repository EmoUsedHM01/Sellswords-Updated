this.legend_helmet_barbarian_berserker <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Top; // Layer 2
		this.m.ID = "armor.head.legend_helmet_barbarian_berserker";
		this.m.Name = "Northern Berserker Band";
		this.m.Description = "A sturdy yet decorative eye-covering worn by berserkers of the northern tribes.";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 1700;
		this.m.Condition = 80;
		this.m.ConditionMax = 80;
		this.m.StaminaModifier = -5;
		this.m.Vision = -2;
		this.m.IsLowerVanity = false;
		this.m.HideHair = true;
		this.m.HideBeard = false;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "bust_yemanren_helmet_" + variant;
		this.m.SpriteDamaged = "bust_yemanren_helmet_" + variant + "_damaged";
		this.m.SpriteCorpse = "bust_yemanren_helmet_" + variant + "_dead";
		this.m.Icon = "helmets/inventory_legend_helmet_barbarian_berserker_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

});