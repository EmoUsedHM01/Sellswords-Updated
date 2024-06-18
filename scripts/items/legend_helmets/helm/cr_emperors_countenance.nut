this.cr_emperors_countenance <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Helm;
		this.m.ID = "armor.head.cr_emperors_countenance";
		this.m.Name = "The Emperor\'s Countenance";
		this.m.Description = "A golden helmet and facemask, showing the visage of an emperor from an age long past, imbued with mystical energies. When you hold it into the light, it almost looks as if the face were moving and making expressions of disgust.";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 12000;
		this.m.Condition = 300;
		this.m.ConditionMax = 300;
		this.m.StaminaModifier = -18;
		this.m.Vision = -2;
		this.m.IsLowerVanity = false;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Legendary;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_golden_helm" + "_" + variant;
		this.m.SpriteDamaged = "legendhelms_golden_helm" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_golden_helm" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_golden_helm" + "_" + variant + ".png";
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
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reflects [color=" + this.Const.UI.Color.PositiveValue + "]25%[/color] of damage taken in melee back to the attacker"
		});
	}

	function onDamageReceived( _damage, _fatalityType, _attacker )
	{
		this.helmet.onDamageReceived(_damage, _fatalityType, _attacker);

		if (_attacker != null && _attacker.isAlive() && _attacker.getHitpoints() > 0 && _attacker.getID() != this.getContainer().getActor().getID() && _attacker.getTile().getDistanceTo(this.getContainer().getActor().getTile()) == 1 && !_attacker.getCurrentProperties().IsImmuneToDamageReflection)
		{
			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.Math.maxf(1.0, _damage * 0.25);
			hitInfo.DamageArmor = this.Math.maxf(1.0, _damage * 0.25);
			hitInfo.DamageDirect = 0.0;
			hitInfo.BodyPart = this.Const.BodyPart.Head;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			_attacker.onDamageReceived(_attacker, null, hitInfo);
		}
	}

});