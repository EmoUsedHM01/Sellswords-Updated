this.cr_orc_grunt_heavy_armor <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.updateVariant();
		this.m.ID = "armor.body.cr_orc_grunt_heavy_armor";
		this.m.Name = "Metal Plated Hide Armor";
		this.m.Description = "";
		this.m.IconLarge = "";
		this.m.Icon = "";
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.m.ShowOnCharacter = true;
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Condition = 220;
		this.m.ConditionMax = 220;
		this.m.StaminaModifier = -28;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_crorc_01_armor_04";
		this.m.SpriteDamaged = "bust_crorc_01_armor_04_damaged";
		this.m.SpriteCorpse = "bust_crorc_01_armor_04_dead";
	}

});

