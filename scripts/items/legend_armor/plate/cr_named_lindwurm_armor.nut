this.cr_named_lindwurm_armor <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;		
		this.m.ID = "armor.body.cr_named_lindwurm_armor";		
		this.m.NameList = [
			"Lindwurm Scales",
			"Dragon\'s Hide",
			"Lizard\'s Coat",
			"Lindwurm Harness",
			"Lindwurm Coat",
			"Wurmscales",
			"Coat of the Lindwurm"
		];
		this.m.Description = "The sturdy scales of a fierce Lindwurm sewn together ontop a heavy chainmail. Not only is it a trophy to a great hunter, but it also deflects the fiercest of blows, and the shimmering scales remain untouched by any corroding Lindwurm blood.";
		this.m.ArmorDescription = "The sturdy scales of a fierce Lindwurm sewn together ontop a heavy chainmail. Not only is it a trophy to a great hunter, but it also deflects the fiercest of blows, and the shimmering scales remain untouched by any corroding Lindwurm blood.";
		this.m.Variant = 113;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 6000;
		this.m.Condition = 130;
		this.m.ConditionMax = 130;
		this.m.StaminaModifier = -14;
		this.randomizeValues();
	}

	function getTooltip()
	{
		local result = this.legend_named_armor_upgrade.getTooltip();
		this.onArmorTooltip(result);
		return result;
	}
	
	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Unaffected by acidic Lindwurm blood"
		});
	}	
	
	function onEquip()
	{
		this.legend_armor_upgrade.onEquip();
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getFlags().add("body_immune_to_acid");
		}
	}

	function onUnequip()
	{
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getFlags().remove("body_immune_to_acid");
		}

		this.legend_armor_upgrade.onUnequip();
	}
	
	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "bust_body_cr113";
		this.m.SpriteDamagedBack = "bust_body_cr113_damaged";
		this.m.SpriteCorpseBack = "bust_body_cr113_dead";
		this.m.Icon = "armor/icon_body_armor_cr113.png";
		this.m.IconLarge = "armor/inventory_body_armor_cr113.png";
		this.m.OverlayIcon = "armor/icon_body_armor_cr113.png";
		this.m.OverlayIconLarge = "armor/inventory_body_armor_cr113.png";		
	}

});

