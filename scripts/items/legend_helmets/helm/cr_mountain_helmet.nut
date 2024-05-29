this.cr_mountain_helmet <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.ID = "armor.head.cr_mountain_helmet";
		this.m.Description = "A helmet crafted from the skin and skull of a mighty rock unhold, the beast may be dead, but it continues to mend itself even after death";
		this.m.Name = "Helmet of the Mountain";
		this.m.IsDroppedAsLoot = true;
		this.m.IsLowerVanity = false;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.Variants = [
			0,
			1
		];
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 7500;
		this.m.Condition = 300;
		this.m.ConditionMax = 300;
		this.m.StaminaModifier = -34;
		this.m.Vision = -3;
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
			text = "Restores 15% helmet armor each turn"
		});
	}

	function onCombatFinished()
	{
		this.m.Condition = this.m.ConditionMax;
		this.getContainer().getActor().setDirty(true);
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local helm = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local helmMissing = helm.getArmorMax() - helm.getArmor();
		local helmAdded = this.Math.min(helmMissing, this.Math.floor(helm.getArmorMax() * 0.15));

		if (helmAdded <= 0)
			return;

		helm.setArmor(helm.getArmor() + helmAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			this.Tactical.spawnIconEffect("status_effect_79", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			this.Sound.play("sounds/enemies/unhold_regenerate_02.wav", this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			this.Tactical.EventLog.log(this.Const.UI.getColorized(this.m.Name, "#1e468f") + " heals for " + helmAdded + " points");
		}
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "bust_mountain_helmet" + "_" + variant;
		this.m.SpriteDamaged = "bust_mountain_helmet" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "bust_mountain_helmet" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/icon_mountain_helmet" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

});