this.crknight_faction_helm_great_helm_faceplate_02 <- this.inherit("scripts/items/legend_helmets/hood/legend_helmet_chain_hood", {
	m = {},
	function create()
	{
		this.legend_helmet_chain_hood.create();
		this.m.ID = "armor.head.crknight_faction_helm_great_helm_faceplate_02";
		this.m.Name = "Chain Hood";
		this.m.Description = "A sturdy chain hood of military grade";
		this.m.Variants = [
			1,
			2,
			3,
			4
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 200;
		this.m.Condition = 80;
		this.m.ConditionMax = 80;
		this.m.StaminaModifier = -4;
		this.m.Vision = 0;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_chain_hood" + "_" + variant;
		this.m.SpriteDamaged = "legendhelms_chain_hood" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_chain_hood" + "_" + variant + "_dead";
		this.m.IconLarge = "";
		this.m.Icon = "legend_helmets/inventory_chain_hood" + "_" + variant + ".png";
	}

	function setupArmor( _variant )
	{
		local helm = this.new("scripts/items/legend_helmets/helm/legend_helmet_great_helm");
		helm.setVariant(1);
		this.setUpgrade(helm);
		local top;
		local r = this.Math.rand(0, 3);		
		if (r == 0)
		{
			top = this.new("scripts/items/legend_helmets/top/legend_helmet_faceplate_winged");		//ss60,-4,800,0
		}
		else if (r == 1)
		{
			top = this.new("scripts/items/legend_helmets/top/legend_helmet_faceplate_pointed");		//ss65,-4,800,-1
		}
		else if (r == 2)
		{
			top = this.new("scripts/items/legend_helmets/top/legend_helmet_faceplate_pointed_slit");		//ss65,-4,800,-1
		}		
		else if (r == 3)
		{
			top = this.new("scripts/items/legend_helmets/top/legend_helmet_faceplate_full");		//ss75,-5,1000,-1
		}
		this.setUpgrade(top);
		local flair = this.new("scripts/items/legend_helmets/vanity/legend_helmet_faction_helmet");
		flair.setVariant(_variant);
		this.setUpgrade(flair);
	}

});

