this.ssu_dryad_mask <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Vanity;
		this.m.ID = "armor.head.ssu_dryad_mask";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_dryad_mask.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_dryad_mask.Description;
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [
			0,
			1,
			2,
			3,
			4,
			5
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ClothEquip;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 700;
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
		this.m.StaminaModifier = -5;
		this.m.Vision = 0;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.ItemType = this.m.ItemType;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "ssu_bust_dryad_helmet" + "_" + variant;
		this.m.SpriteDamaged = "ssu_bust_dryad_helmet" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "ssu_bust_dryad_helmet" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/ssu_dryad_icon_helmet" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

	function getTooltip()
	{
		local result = this.legend_helmet_upgrade.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/repair_item.png",
			text = ::Mod_Sellswords.Strings.ssu_dryad_mask.Tooltip
		});
		return result;
	}
	
	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/repair_item.png",
			text = ::Mod_Sellswords.Strings.ssu_dryad_mask.Tooltip
		});
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local head = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local headMissing = head.getArmorMax() - head.getArmor();
		local headAdded = this.Math.min(headMissing, 10);

		if (headAdded <= 0)
		{
			return;
		}

		head.setArmor(head.getArmor() + headAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			this.Tactical.spawnIconEffect("status_effect_79", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			this.Sound.play("sounds/enemies/dlc2/schrat_idle_05.wav", this.Const.Sound.Volume.RacialEffect * 2.0, actor.getPos());
			this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_dryad_mask.Log, this.Const.UI.getColorized(this.m.Name, "#1e468f"), headAdded));
		}
	}
	
});

