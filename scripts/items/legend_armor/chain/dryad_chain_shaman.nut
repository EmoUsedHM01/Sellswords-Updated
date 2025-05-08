this.dryad_chain_shaman <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Chain;
		this.m.ID = "legend_armor.body.dryad_chain_shaman";
		this.m.Name = "Greenwood Shaman's Gorget";
		this.m.Description = "A thick wooden gorget. Whatever magic was used to craft it seems to have lingered, slowly regrowing the armour when damaged.";
		this.m.ArmorDescription = "";
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 550;
		this.m.Condition = 30;
		this.m.ConditionMax = 30;
		this.m.StaminaModifier = -3;
		this.m.ItemType = this.m.ItemType;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "bust_dryad_chain" + "_" + variant;
		this.m.SpriteDamagedBack = "bust_dryad_chain" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "bust_dryad_chain" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_dryad_chain" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_dryad_chain" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_dryad_chain" + "_" + variant + ".png";
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/repair_item.png",
			text = "Repairs [color=" + this.Const.UI.Color.PositiveValue + "]5[/color] armour each turn"
		});
		return result;
	}
	
	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/repair_item.png",
			text = "Repairs [color=" + this.Const.UI.Color.PositiveValue + "]5[/color] armour each turn"
		});
	}
});

