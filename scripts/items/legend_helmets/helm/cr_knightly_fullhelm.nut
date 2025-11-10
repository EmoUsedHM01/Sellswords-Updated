this.cr_knightly_fullhelm <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Helm;
		this.m.ID = "armor.head.cr_knightly_fullhelm";
		this.m.Name = "Greenskin Killer Fullhelm";
		this.m.Description = "An embellished helm of a knight with a beautiful design that melds both aesthetics and practicality. The visage is something that strikes fear into the heart of Goblins for they are aware of what a hunter looks like.";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [
			0
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 3000;
		this.m.Condition = 180;
		this.m.ConditionMax = 180;
		this.m.StaminaModifier = -14;
		this.m.Vision = -2;
		this.m.IsLowerVanity = false;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.ItemType = this.m.ItemType;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "bust_knightly_fullhelm" + "_" + variant;
		this.m.SpriteDamaged = "bust_knightly_fullhelm" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "bust_knightly_fullhelm" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/icon_knightly_fullhelm" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}
	
	function getTooltip()
	{
		local result = this.legend_helmet_upgrade.getTooltip();
		this.onArmorTooltip(result);
		return result;
	}
	
	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/health.png",
			text = "User deals [color=%positive%]20%[/color] more damage to Goblins"
		});
	}
	
	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

		if (_targetEntity.getType() == this.Const.FactionType.Goblins)
		{
			_properties.DamageRegularMin *= 1.2;
			_properties.DamageRegularMax *= 1.2;
		}
		else
		{
			return;
		}
	}

});
