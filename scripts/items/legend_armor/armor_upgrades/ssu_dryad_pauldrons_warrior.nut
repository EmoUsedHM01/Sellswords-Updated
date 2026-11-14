this.ssu_dryad_pauldrons_warrior <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.ID = "legend_armor_upgrade.ssu_dryad_pauldrons_warrior";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_dryad_pauldrons_warrior.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_dryad_pauldrons_warrior.Description;
		this.m.ArmorDescription = "";
		this.m.Variants = [
			2
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 1550;
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
		this.m.StaminaModifier = -8;
		this.m.ItemType = this.m.ItemType;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "ssu_bust_dryad_pauldrons" + "_" + variant;
		this.m.SpriteDamagedBack = "ssu_bust_dryad_pauldrons" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "ssu_bust_dryad_pauldrons" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/ssu_dryad_icon_pauldrons" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/ssu_dryad_icon_pauldrons" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/ssu_dryad_inventory_pauldrons" + "_" + variant + ".png";
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/repair_item.png",
			text = ::Mod_Sellswords.Strings.ssu_dryad_pauldrons_warrior.Tooltip
		});
		return result;
	}
	
	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/repair_item.png",
			text = ::Mod_Sellswords.Strings.ssu_dryad_pauldrons_warrior.Tooltip
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
			this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_dryad_pauldrons_warrior.Log, this.Const.UI.getColorized(this.m.Name, "#1e468f"), bodyAdded));
		}
	}
	
});