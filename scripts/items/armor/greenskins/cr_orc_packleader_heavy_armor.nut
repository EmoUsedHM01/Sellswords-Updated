this.cr_orc_packleader_heavy_armor <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.updateVariant();
		this.m.ID = "armor.cr_orc_packleader_heavy_armor";
		this.m.Name = "Looted Plate Armor";
		this.m.Description = "";
		this.m.IconLarge = "";
		this.m.Icon = "";
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.m.ShowOnCharacter = true;
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Condition = 460;
		this.m.ConditionMax = 460;
		this.m.StaminaModifier = -58;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_crorc_03_armor_04";
		this.m.SpriteDamaged = "bust_crorc_03_armor_04_damaged";
		this.m.SpriteCorpse = "bust_crorc_03_armor_04_dead";
	}

});

