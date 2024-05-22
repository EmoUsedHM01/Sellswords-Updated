this.crknight_faction_helm_great_helm_armet_heavy <- this.inherit("scripts/items/legend_helmets/hood/legend_helmet_enclave_bevor", {
	m = {},
	function create()
	{
		this.legend_helmet_enclave_bevor.create();
		this.m.ID = "armor.head.crknight_faction_helm_great_helm_armet_heavy";
		this.m.Name = "Bevor";
		this.m.Description = "A solid metal bevor.";
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 1200;
		this.m.Condition = 120;
		this.m.ConditionMax = 120;
		this.m.StaminaModifier = -8;
		this.m.Vision = 0;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_enclave_bevor" + "_" + variant;
		this.m.SpriteDamaged = "legendhelms_enclave_bevor" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_enclave_bevor" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_enclave_bevor" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
	}

	function setupArmor( _variant )
	{
		local helm = this.new("scripts/items/legend_helmets/helm/legend_helmet_legend_armet");
		helm.setVariant(1);
		this.setUpgrade(helm);
		local flair = this.new("scripts/items/legend_helmets/vanity/legend_helmet_faction_helmet");
		flair.setVariant(_variant);
		this.setUpgrade(flair);
	}

});

