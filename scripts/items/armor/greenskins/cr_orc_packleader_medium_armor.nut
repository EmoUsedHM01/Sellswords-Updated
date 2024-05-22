this.cr_orc_packleader_medium_armor <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.updateVariant();
		this.m.ID = "armor.body.cr_orc_packleader_medium_armor";
		this.m.Name = "Looted Reinforced Mail";
		this.m.Description = "";
		this.m.IconLarge = "";
		this.m.Icon = "";
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.m.ShowOnCharacter = true;
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Condition = 420;
		this.m.ConditionMax = 420;
		this.m.StaminaModifier = -52;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_crorc_03_armor_03";
		this.m.SpriteDamaged = "bust_crorc_03_armor_03_damaged";
		this.m.SpriteCorpse = "bust_crorc_03_armor_03_dead";
	}

});

