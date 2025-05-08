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
			text = "Regrows [color=" + this.Const.UI.Color.PositiveValue + "]"+ 5 + "[/color] armour each turn"
		});
		return result;
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();

		local layersWithRegen = findLayersWithRegenFor(actor);
		local armorRegen = calculateRegenFrom(layersWithRegen);

		applyArmorRegenTo(actor, armorRegen);
	}

	function findLayersWithRegenFor( _actor )
	{
		local body = _actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		if (body == null)
		{
			return;
		}

		local upgradeTypes = body.getUpgrades();

		local layersWithRegen = [];
		for( local i = 0; i < upgradeTypes.len(); i++ )
		{
			local upgradeType = upgradeTypes[i];
			if (upgradeType != null && upgradeType ==  1) { // 1 is visible upgrade
				local layer = body.getUpgrade(i);

				if (hasRegen(layer)) {
					layersWithRegen.push(layer);
				}
			}
		}

		// check the armor base layer
		if (hasRegen(this))
		{
			layersWithRegen.push(this);
		}
		local totalLayers = upgradeTypes.len() + 1;
		this.logInfo("Found : " + layersWithRegen.len() + " regenerating layers out of " + totalLayers);
		return layersWithRegen;
	}

	function hasRegen ( _armor ) {
		return _armor.m.ID.find("dryad") != null;
	}

	function calculateRegenFrom( _layers)
	{
		local totalRegen = 0;

		foreach (layer in _layers)
		{
			if (layer.m.ConditionMax == layer.m.Condition) {
				// only damaged layers will contribute to regeneration
				continue;
			}
			local regenValue = regenValueFor(layer);
			totalRegen += regenValue;

			this.Tactical.EventLog.log(this.Const.UI.getColorized(layer.m.Name, "#1e468f") + " contributes " + regenValue + " armor regen");
		}

		return totalRegen;
	}

	function regenValueFor( _layer ) {
		return this.Math.min(_layer.m.ConditionMax - _layer.m.Condition, 5);
	}


	function applyArmorRegenTo( _actor, _regenValue ) {
		if (_regenValue <= 0)
		{
			return;
		}

		if (!_actor.isHiddenToPlayer())
		{
			this.Tactical.spawnIconEffect(
				"status_effect_79",
				_actor.getTile(),
				this.Const.Tactical.Settings.SkillIconOffsetX,
				this.Const.Tactical.Settings.SkillIconOffsetY,
				this.Const.Tactical.Settings.SkillIconScale,
				this.Const.Tactical.Settings.SkillIconFadeInDuration,
				this.Const.Tactical.Settings.SkillIconStayDuration,
				this.Const.Tactical.Settings.SkillIconFadeOutDuration,
				this.Const.Tactical.Settings.SkillIconMovement
				);
		}
		this.Sound.play("sounds/enemies/dlc2/schrat_idle_05.wav", this.Const.Sound.Volume.RacialEffect * 2.0, _actor.getPos());

		local body = _actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		body.addArmor(_regenValue); // this will repair all layers, even non-dryad ones from bottom up

		this.Tactical.EventLog.log(this.Const.UI.getColorized(this.m.Name, "#1e468f") + " regrows by " + _regenValue + " points");
	}

});

