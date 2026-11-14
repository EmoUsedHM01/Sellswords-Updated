this.ssu_orc_packleader_heavy_armor <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.updateVariant();
		this.m.ID = "armor.ssu_orc_packleader_heavy_armor";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_orc_packleader_heavy_armor.Name;
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
		this.m.Sprite = "ssu_bust_orc_03_armor_04";
		this.m.SpriteDamaged = "ssu_bust_orc_03_armor_04_damaged";
		this.m.SpriteCorpse = "ssu_bust_orc_03_armor_04_dead";
	}

});

