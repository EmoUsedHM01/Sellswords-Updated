this.cr_orc_berserker_light_armor <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.updateVariant();
		this.m.ID = "armor.body.cr_orc_berserker_light_armor";
		this.m.Name = "Trophy Bones";
		this.m.Description = "";
		this.m.IconLarge = "";
		this.m.Icon = "";
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.m.ShowOnCharacter = true;
		this.m.ImpactSound = [
			"sounds/enemies/skeleton_hurt_03.wav"
		];
		this.m.Condition = 180;
		this.m.ConditionMax = 180;
		this.m.StaminaModifier = -22;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_crorc_02_armor_01";
		this.m.SpriteDamaged = "bust_crorc_02_armor_01_damaged";
		this.m.SpriteCorpse = "bust_crorc_02_armor_01_dead";
	}

});

