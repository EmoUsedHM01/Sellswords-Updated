this.ssu_helmet_orc_packleader_medium_helm <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		local variants = [
			2,
			5
		];
		this.m.Variant = variants[this.Math.rand(0, variants.len() - 1)];
		this.updateVariant();
		this.m.ID = "armor.head.ssu_helmet_orc_packleader_medium_helm";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_helmet_orc_packleader_medium_helm.Name;
		this.m.Description = "";
		this.m.ShowOnCharacter = true;
		this.m.IconLarge = "";
		this.m.Icon = "";
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Condition = 380;
		this.m.ConditionMax = 380;
		this.m.StaminaModifier = -35;
		this.m.Vision = -2;			
	}

	function updateVariant()
	{
		this.m.Sprite = "ssu_bust_orc_03_helmet_05";
		this.m.SpriteDamaged = "ssu_bust_orc_03_helmet_05_damaged";
		this.m.SpriteCorpse = "ssu_bust_orc_03_helmet_05_dead";
	}

});

