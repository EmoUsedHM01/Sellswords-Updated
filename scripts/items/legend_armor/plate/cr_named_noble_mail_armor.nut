this.cr_named_noble_mail_armor <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;		
		this.m.ID = "armor.body.cr_named_noble_mail_armor";	
		this.m.NameList = [
			"Reinforced Mail",
			"Nightcloak",
			"Noble Mail",
			"Fencing Mail"
		];
		this.m.Description = "This piece of light mail armor was once the personal item of a well known fencing master. It is as light as a tunic, but protects all vital body parts.";
		this.m.ArmorDescription = "This piece of light mail armor was once the personal item of a well known fencing master. It is as light as a tunic, but protects all vital body parts.";
		this.m.Variant = 100;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 4000;
		this.m.Condition = 130;
		this.m.ConditionMax = 130;
		this.m.StaminaModifier = -14;
		this.randomizeValues();
	}
	
	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "bust_body_cr100";
		this.m.SpriteDamagedBack = "bust_body_cr100_damaged";
		this.m.SpriteCorpseBack = "bust_body_cr100_dead";
		this.m.Icon = "armor/icon_body_armor_cr100.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor/icon_body_armor_cr100.png";
		this.m.OverlayIconLarge = "armor/inventory_body_armor_cr100.png";		
	}

	function randomizeValues()
	{
		this.m.StaminaModifier = this.Math.rand(8, 10) * -1;
		this.m.Condition = this.Math.rand(115, 130);
		this.m.ConditionMax = this.m.Condition;
	}	

});

