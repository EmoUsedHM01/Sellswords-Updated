this.dryad_cloak_tamer <- this.inherit("scripts/items/legend_armor/legend_armor_cloak", {
	m = {},
	function create()
	{
		this.legend_armor_cloak.create();
		this.m.ID = "legend_armor.body.dryad_cloak_tamer";
		this.m.Name = "Greenwood Tamer's Cloak";
		this.m.Description = "A magnificent growth of plants which feels as tough as it is intimiating to your enemies. Whatever magic was used to craft it seems to have lingered, slowly regrowing the armour when damaged.";
		this.m.ArmorDescription = "";
		this.m.Variants = [
			4
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ClothEquip;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 600;
		this.m.Condition = 25;
		this.m.ConditionMax = 25;
		this.m.StaminaModifier = -4;
		this.m.ItemType = this.m.ItemType;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "bust_dryad_cloak" + "_" + variant;
		this.m.SpriteDamagedBack = "bust_dryad_cloak" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "bust_dryad_cloak" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_dryad_cloak" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_dryad_cloak" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_dryad_cloak" + "_" + variant + ".png";
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
