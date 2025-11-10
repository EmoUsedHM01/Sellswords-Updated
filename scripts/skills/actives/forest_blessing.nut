this.forest_blessing <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.forest_blessing";
		this.m.Name = "Blessings of the Forest";
		this.m.Description = "Instill a target with the power of the Forest's Heart for two turns, granting them additional damage and combat ability. Can not be used while engaged in melee.";
		this.m.Icon = "skills/dryad_forest_blessing.png";
		this.m.IconDisabled = "skills/dryad_forest_blessing_sw.png";
		this.m.Overlay = "dryad_buff_active";
		this.m.SoundOnUse = [
			"sounds/combat/perfect_focus_01.wav"
		];
		this.m.SoundVolume = 0.5;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 30;
		this.m.MinRange = 0;
		this.m.MaxRange = 4;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		local ammo = this.getAmmo();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=%positive%]" + this.m.MaxRange + "[/color], can only target damaged units."
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=%positive%]+25%[/color] Damage"
		});
		ret.push({
			id = 9,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = "[color=%positive%]+15[/color] Melee Skill"
		});
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = "[color=%positive%]+15[/color] Ranged Skill"
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=%positive%]+15[/color] Melee Defense"
		});
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = "[color=%positive%]+15[/color] Ranged Defense"
		});

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=%positive%]" + ammo + "[/color] charges left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Needs a heart filled with power equipped[/color]"
			});
		}

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return ret;
	}

	function isUsable()
	{
		return !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 0 && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function getAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);

		if (item == null)
			return 0;

		if (item.getAmmoType() == this.Const.Items.AmmoType.Heart)
			return item.getAmmo();
	}

	function consumeAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);

		if (item != null)
			item.consumeAmmo();
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
			return false;

		local target = _targetTile.getEntity();

		if (target == null)
			return false;

		if (!this.m.Container.getActor().isAlliedWith(target))
			return false;

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local effect = target.getSkills().getSkillByID("effects.forest_blessing_effect");

		if (effect != null)
			effect.resetTime();
		else
			target.getSkills().add(this.new("scripts/skills/effects/forest_blessing_effect"));

		this.consumeAmmo();
		return true;
	}

});