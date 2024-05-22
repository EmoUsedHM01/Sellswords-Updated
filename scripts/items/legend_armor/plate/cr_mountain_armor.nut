this.cr_mountain_armor <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;		
		this.m.ID = "armor.body.cr_mountain_armor";	
		this.m.Name = "Mountain Armour";
		this.m.Description = "Armor crafted from the skin and bones of a mighty rock unhold, the beast may be dead, but it continues to mend itself even after death.";
		this.m.ArmorDescription = "Armor crafted from the skin and bones of a mighty rock unhold, the beast may be dead, but it continues to mend itself even after death.";
		this.m.Variant = 516;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 7500;
		this.m.Condition = 250;
		this.m.ConditionMax = 250;
		this.m.StaminaModifier = -32;
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		this.onArmorTooltip(result);
		return result;
	}
	
	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/health.png",
			text = "Repairs [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] of its armor each turn"
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
		local body = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local bodyMissing = body.getArmorMax() - body.getArmor();
		local bodyAdded = this.Math.min(bodyMissing, this.Math.floor(body.getArmorMax() * 0.1));

		if (bodyAdded <= 0)
		{
			return;
		}

		body.setArmor(body.getArmor() + bodyAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			this.Tactical.spawnIconEffect("status_effect_79", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			this.Sound.play("sounds/enemies/unhold_regenerate_01.wav", this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			this.Tactical.EventLog.log(this.Const.UI.getColorized(this.m.Name, "#1e468f") + " heals for " + bodyAdded + " points");
		}
	}
	
	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "bust_body_cr516";
		this.m.SpriteDamagedBack = "bust_body_cr516_damaged";
		this.m.SpriteCorpseBack = "bust_body_cr516_dead";
		this.m.Icon = "armor/icon_body_armor_cr516.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor/icon_body_armor_cr516.png";
		this.m.OverlayIconLarge = "armor/inventory_body_armor_cr516.png";		
	}

});
