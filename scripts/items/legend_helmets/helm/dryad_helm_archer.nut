this.dryad_helm_archer <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Helm;
		this.m.ID = "armor.head.dryad_helm_archer";
		this.m.Name = "Dryad Archer's Helm";
		this.m.Description = "A sturdy wooden helm, pilfered from the corpse of a Dryad. For some reason it seems to slowly stitch itself back together when damaged.";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [
			0
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 1200;
		this.m.Condition = 70;
		this.m.ConditionMax = 70;
		this.m.StaminaModifier = -6;
		this.m.Vision = -0;
		this.m.IsLowerVanity = false;
		this.m.HideHair = true;
		this.m.HideBeard = true;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "bust_dryad_helmet" + "_" + variant;
		this.m.SpriteDamaged = "bust_dryad_helmet" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "bust_dryad_helmet" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/icon_dryad_helmet" + "_" + variant + ".png";
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
			icon = "ui/icons/repair_item.png",
			text = "Repairs [color=%positive%]10[/color] armour each turn"
		});
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local head = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local headMissing = head.getArmorMax() - head.getArmor();
		local headAdded = this.Math.min(headMissing, 10);

		if (headAdded <= 0)
			return;

		head.setArmor(head.getArmor() + headAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			this.Tactical.spawnIconEffect("status_effect_79", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			this.Sound.play("sounds/enemies/dlc2/schrat_idle_05.wav", this.Const.Sound.Volume.RacialEffect * 2.0, actor.getPos());
			this.Tactical.EventLog.log(this.Const.UI.getColorized(this.m.Name, "#1e468f") + " repaired for " + headAdded + " points");
		}
	}

});