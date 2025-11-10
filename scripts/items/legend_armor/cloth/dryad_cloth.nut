this.dryad_cloth <- this.inherit("scripts/items/legend_armor/legend_armor", {
	m = {},
	function create()
	{
		this.legend_armor.create();
		this.m.ID = "legend_armor.body.dryad_cloth";
		this.m.Name = "Dryad Gown";
		this.m.Description = "A long and soft gown, magically woven from long leaves. Whatever magic was used to craft it seems to have lingered, slowly regrowing it when damaged.";
		this.m.Variants = [
			0
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ClothEquip;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 500;
		this.m.Condition = 20;
		this.m.ConditionMax = 20;
		this.m.StaminaModifier = -1;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.ItemType = this.m.ItemType;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "bust_dryad_cloth" + "_" + variant;
		this.m.SpriteDamaged = "bust_dryad_cloth" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "bust_dryad_cloth" + "_" + variant + "_dead";
		this.m.IconLarge = "legend_armor/inventory_dryad_cloth" + "_" + variant + ".png";
		this.m.Icon = "legend_armor/icon_dryad_cloth" + "_" + variant + ".png";
	}

	function getTooltip()
	{
		local result = this.legend_armor.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/repair_item.png",
			text = "Repairs [color=%positive%]5[/color] armour each turn"
		});
		return result;
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

