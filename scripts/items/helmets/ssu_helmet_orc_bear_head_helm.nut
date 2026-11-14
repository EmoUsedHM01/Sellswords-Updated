this.ssu_helmet_orc_bear_head_helm <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		local variants = [
			1
		];
		this.m.Variant = variants[this.Math.rand(0, variants.len() - 1)];
		this.updateVariant();
		this.m.ID = "armor.head.ssu_helmet_orc_bear_head_helm";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_helmet_orc_bear_head_helm.Name;
		this.m.Description = "";
		this.m.ShowOnCharacter = true;
		this.m.IconLarge = "";
		this.m.Icon = "";
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Condition = 160;
		this.m.ConditionMax = 160;
		this.m.StaminaModifier = -14;
		this.m.Vision = -1;		
	}

	function updateVariant()
	{
		this.m.Sprite = "ssu_bust_greenskin_11_helmet_01";
		this.m.SpriteDamaged = "ssu_bust_greenskin_11_helmet_01_damaged";
		this.m.SpriteCorpse = "ssu_bust_greenskin_11_helmet_01_dead";
	}

});

