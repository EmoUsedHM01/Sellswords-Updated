this.necro_embalmbed_priest_body <- this.inherit("scripts/items/legend_armor/legend_armor_tabard", {
	function create()
	{
		this.legend_armor_tabard.create();
		this.m.ID = "legend_armor.body.necro_embalmbed_priest_body";
		this.m.Name = "Ancient Priest Garb";
		this.m.Description = "An ancient dressing for the priests of a civilisation long past. The priests that would wear this were often the centrepiece of horrific ritualistic sacrifice, offering their body and soul on an grim altar to appease their ancient Gods.";
		this.m.ArmorDescription = "An ancient dressing for the priests of a civilisation long past.";
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Variant = 1;
		this.updateVariant();
		this.m.Value = 800;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = 0;
		this.m.Bravery = 3;
		this.m.ItemType = this.m.ItemType;
	}

	function updateVariant()
	{
		this.m.SpriteBack = "mummy_dress_01";
		this.m.SpriteDamagedBack = "mummy_dress_01_damaged";
		this.m.SpriteCorpseBack = "mummy_dress_01_dead";
		this.m.Icon = "legend_armor/icon_necro_embalmbed_priest_body.png";
		this.m.IconLarge = "legend_armor/inventory_necro_embalmbed_priest_body.png";
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.IconLarge;
	}

});