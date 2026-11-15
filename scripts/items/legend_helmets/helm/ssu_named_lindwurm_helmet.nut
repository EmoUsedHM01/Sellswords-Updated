this.ssu_named_lindwurm_helmet <- this.inherit("scripts/items/legend_helmets/legend_named_helmet_upgrade", {
	m = {
		Potential = {
			Condition = { min = 168, max = 189 },
			StaminaModifier = { min = 8, max = 8 },
			Vision = { min = 2, max = 2 }
		}
	},
	function create()
	{
		this.legend_named_helmet_upgrade.create();
		this.m.ID = "armor.head.ssu_named_lindwurm_helmet";
		this.m.Description = ::Mod_Sellswords.Strings.ssu_named_lindwurm_helmet.Description;
		this.m.NameList = [
			"Lindwurm\'s Head",
			"Lizard Headpiece",
			"Dragon\'s Dome",
			"Lindwurm Ward",
			"Wurmscale Helmet",
			"Lindwurm Mask"
		];
		this.m.Variants = [
			0,
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 5000;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.IsDroppedAsLoot = true;
		this.m.Type = this.Const.Items.HelmetUpgrades.Helm;
		this.m.ItemType = this.m.ItemType;
		this.randomizeValues();
	}

	function getTooltip()
	{
		local result = this.legend_named_helmet_upgrade.getTooltip();
		this.onArmorTooltip(result);
		return result;
	}

	function onArmorTooltip( result )
	{
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_named_lindwurm_helmet.Tooltip
		});
	}

	function onEquip()
	{
		this.legend_named_helmet_upgrade.onEquip();
		
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
			c.getActor().getFlags().add("head_immune_to_acid");
	}

	function onUnequip()
	{
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
			c.getActor().getFlags().remove("head_immune_to_acid");

		this.legend_named_helmet_upgrade.onUnequip();
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "ssu_bust_lindwurm_helmet" + "_" + variant;
		this.m.SpriteDamaged = "ssu_bust_lindwurm_helmet" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "ssu_bust_lindwurm_helmet" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/ssu_icon_lindwurm_helmet" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

});