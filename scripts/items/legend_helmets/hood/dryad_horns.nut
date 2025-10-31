this.dryad_horns <- this.inherit("scripts/items/legend_helmets/legend_helmet", {
	m = {},
	function create()
	{
		this.legend_helmet.create();
		this.m.ID = "armor.head.dryad_horns";
		this.m.Name = "Dryad Horns";
		this.m.Description = "Long protruding horns grown from the head of a Dryad.";
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
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 260;
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
		this.m.StaminaModifier = -4;
		this.m.Vision = 0;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.ItemType = this.m.ItemType;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "bust_dryad_horns" + "_" + variant;
		this.m.SpriteDamaged = "bust_dryad_horns" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "bust_dryad_horns" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/icon_dryad_horns" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
	}

	function getTooltip()
	{
		local result = this.legend_helmet.getTooltip();
		this.onArmorTooltip(result);
		return result;
	}
	
	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/repair_item.png",
			text = "Repairs [color=" + this.Const.UI.Color.PositiveValue + "]10[/color] armour each turn"
		});
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
		local head = _actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		if (head == null)
		{
			return;
		}

		local upgradeTypes = head.getUpgrades();

		local layersWithRegen = [];
		for( local i = 0; i < upgradeTypes.len(); i++ )
		{
			local upgradeType = upgradeTypes[i];
			if (upgradeType != null && upgradeType ==  1) { // 1 is visible upgrade
				local layer = head.getUpgrade(i);

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
		return this.Math.min(_layer.m.ConditionMax - _layer.m.Condition, 10);
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

		local head = _actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		head.addArmor(_regenValue); // this will repair all layers, even non-dryad ones from bottom up

		this.Tactical.EventLog.log(this.Const.UI.getColorized(this.m.Name, "#1e468f") + " regrows by " + _regenValue + " points");
	}

});