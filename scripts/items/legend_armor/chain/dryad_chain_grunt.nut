this.dryad_chain_grunt <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Chain;
		this.m.ID = "legend_armor.body.dryad_chain_grunt";
		this.m.Name = "Greenwood Gorget";
		this.m.Description = "A thick wooden gorget. Whatever magic was used to craft it seems to have lingered, slowly regrowing the armour when damaged.";
		this.m.ArmorDescription = "";
		this.m.Variants = [
			3
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 950;
		this.m.Condition = 50;
		this.m.ConditionMax = 50;
		this.m.StaminaModifier = -5;
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
			text = "Repairs [color=%positive%]5[/color] armour each turn"
		});
		return result;
	}
	
	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/repair_item.png",
			text = "Repairs [color=%positive%]5[/color] armour each turn"
		});
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local body = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local bodyMissing = body.getArmorMax() - body.getArmor();
		local bodyAdded = this.Math.min(bodyMissing, 5);

		if (bodyAdded <= 0)
		{
			return;
		}

		body.setArmor(body.getArmor() + bodyAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			this.Tactical.spawnIconEffect("status_effect_79", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			this.Sound.play("sounds/enemies/dlc2/schrat_idle_05.wav", this.Const.Sound.Volume.RacialEffect * 2.0, actor.getPos());
			this.Tactical.EventLog.log(this.Const.UI.getColorized(this.m.Name, "#1e468f") + " repaired for " + bodyAdded + " points");
		}
	}
	
});

