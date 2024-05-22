this.guerdan_armor <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.updateVariant();
		this.m.ID = "armor.body.guerdan_armor";
		this.m.Name = "Heavy Armor";
		this.m.Description = "";
		this.m.IconLarge = "";
		this.m.Icon = "";
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.m.ShowOnCharacter = true;
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Condition = 300;
		this.m.ConditionMax = 300;
		this.m.StaminaModifier = -35;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_lvpi_06_armor_01";
		this.m.SpriteDamaged = "bust_lvpi_06_armor_01_damaged";
		this.m.SpriteCorpse = "bust_lvpi_06_armor_01_dead";
	}

});

