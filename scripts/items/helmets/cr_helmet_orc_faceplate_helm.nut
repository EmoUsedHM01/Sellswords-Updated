this.cr_helmet_orc_faceplate_helm <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		local variants = [
			3
		];
		this.m.Variant = variants[this.Math.rand(0, variants.len() - 1)];
		this.updateVariant();
		this.m.ID = "armor.head.cr_helmet_orc_faceplate_helm";
		this.m.Name = "Metal Plated Helmet";
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
		this.m.Sprite = "bust_crorc_01_helmet_01";
		this.m.SpriteDamaged = "bust_crorc_01_helmet_01_damaged";
		this.m.SpriteCorpse = "bust_crorc_01_helmet_01_dead";
	}

});

