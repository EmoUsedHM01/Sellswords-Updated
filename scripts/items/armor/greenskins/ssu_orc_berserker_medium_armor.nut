this.ssu_orc_berserker_medium_armor <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.updateVariant();
		this.m.ID = "armor.body.ssu_orc_berserker_medium_armor";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_orc_berserker_medium_armor.Name;
		this.m.Description = "";
		this.m.IconLarge = "";
		this.m.Icon = "";
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.m.ShowOnCharacter = true;
		this.m.ImpactSound = [
			"sounds/enemies/skeleton_hurt_03.wav"
		];
		this.m.Condition = 240;
		this.m.ConditionMax = 240;
		this.m.StaminaModifier = -28;
	}

	function updateVariant()
	{
		this.m.Sprite = "ssu_bust_orc_02_armor_02";
		this.m.SpriteDamaged = "ssu_bust_orc_02_armor_02_damaged";
		this.m.SpriteCorpse = "ssu_bust_orc_02_armor_02_dead";
	}

});

