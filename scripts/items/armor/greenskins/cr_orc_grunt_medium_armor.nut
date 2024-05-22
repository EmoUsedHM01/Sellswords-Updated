this.cr_orc_grunt_medium_armor <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.updateVariant();
		this.m.ID = "armor.body.cr_orc_grunt_medium_armor";
		this.m.Name = "Hide Armor";
		this.m.Description = "";
		this.m.IconLarge = "";
		this.m.Icon = "";
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.m.ShowOnCharacter = true;
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Condition = 190;
		this.m.ConditionMax = 190;
		this.m.StaminaModifier = -24;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_crorc_01_armor_03";
		this.m.SpriteDamaged = "bust_crorc_01_armor_03_damaged";
		this.m.SpriteCorpse = "bust_crorc_01_armor_03_dead";
	}

});

