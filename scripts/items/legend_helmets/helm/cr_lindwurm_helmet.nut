this.cr_lindwurm_helmet <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.ID = "armor.head.cr_lindwurm_helmet";
		this.m.Description = "This helmet must have once belonged to a daring and skilled hunter for it is covered in the scales of a dreaded Lindwurm. Not only do the scales deflect blows and hits, but they also remain unscathed by the acidic Lindwurm blood.";
		this.m.Name = "Lindwurm Scaled Helmet";
		this.m.Variant = 152;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 2500;
		this.m.Condition = 140;
		this.m.ConditionMax = 140;
		this.m.StaminaModifier = -10;
		this.m.Vision = -2;
		this.m.IsLowerVanity = false;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.IsDroppedAsLoot = true;
		this.m.Type = this.Const.Items.HelmetUpgrades.Helm;
		this.m.ItemType = this.m.ItemType;
	}

	function getTooltip()
	{
		local result = this.legend_helmet_upgrade.getTooltip();
		this.onArmorTooltip(result);
		return result;
	}

	function onArmorTooltip( result )
	{
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Unaffected by acidic Lindwurm blood"
		});
	}

	function onEquip()
	{
		this.legend_helmet_upgrade.onEquip();
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getFlags().add("head_immune_to_acid");
		}
	}

	function onUnequip()
	{
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getFlags().remove("head_immune_to_acid");
		}

		this.legend_helmet_upgrade.onUnequip();
	}	
	
	function updateVariant()
	{
		this.m.Sprite = "bust_helmet_cr152";
		this.m.SpriteDamaged = "bust_helmet_cr152_damaged";
		this.m.SpriteCorpse = "bust_helmet_cr152_dead";
		this.m.Icon = "helmets/inventory_helmet_cr152.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

});

