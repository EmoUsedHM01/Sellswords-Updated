this.cr_orc_grunt_light_armor <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.updateVariant();
		this.m.ID = "armor.body.cr_orc_grunt_light_armor";
		this.m.Name = "Hide Armor";
		this.m.Description = "";
		this.m.IconLarge = "";
		this.m.Icon = "";
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.m.ShowOnCharacter = true;
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Condition = 160;
		this.m.ConditionMax = 160;
		this.m.StaminaModifier = -20;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_crorc_01_armor_02";
		this.m.SpriteDamaged = "bust_crorc_01_armor_02_damaged";
		this.m.SpriteCorpse = "bust_crorc_01_armor_02_dead";
	}

});

