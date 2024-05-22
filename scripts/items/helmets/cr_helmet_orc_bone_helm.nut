this.cr_helmet_orc_bone_helm <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		local variants = [
			2
		];
		this.m.Variant = variants[this.Math.rand(0, variants.len() - 1)];
		this.updateVariant();
		this.m.ID = "armor.head.cr_helmet_orc_bone_helm";
		this.m.Name = "Helmet";
		this.m.Description = "";
		this.m.ShowOnCharacter = true;
		this.m.IconLarge = "";
		this.m.Icon = "";
		this.m.ImpactSound = [
			"sounds/enemies/skeleton_hurt_03.wav"
		];
		this.m.Condition = 190;
		this.m.ConditionMax = 190;
		this.m.StaminaModifier = -16;
		this.m.Vision = -1;			
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_lvpi_08_helmet_01";
		this.m.SpriteDamaged = "bust_lvpi_08_helmet_01_damaged";
		this.m.SpriteCorpse = "bust_lvpi_08_helmet_01_dead";
	}

});

