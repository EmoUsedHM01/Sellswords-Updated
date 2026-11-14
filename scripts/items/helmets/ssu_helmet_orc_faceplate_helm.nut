this.ssu_helmet_orc_faceplate_helm <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		local variants = [
			3
		];
		this.m.Variant = variants[this.Math.rand(0, variants.len() - 1)];
		this.updateVariant();
		this.m.ID = "armor.head.ssu_helmet_orc_faceplate_helm";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_helmet_orc_faceplate_helm.Name;
		this.m.Description = "";
		this.m.ShowOnCharacter = true;
		this.m.IconLarge = "";
		this.m.Icon = "";
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Condition = 220;
		this.m.ConditionMax = 220;
		this.m.StaminaModifier = -18;
	}

	function updateVariant()
	{
		this.m.Sprite = "ssu_bust_orc_01_helmet_01";
		this.m.SpriteDamaged = "ssu_bust_orc_01_helmet_01_damaged";
		this.m.SpriteCorpse = "ssu_bust_orc_01_helmet_01_dead";
	}

});

