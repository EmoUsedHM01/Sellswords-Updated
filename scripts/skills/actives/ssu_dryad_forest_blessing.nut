this.ssu_dryad_forest_blessing <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.ssu_dryad_forest_blessing";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_dryad_forest_blessing.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_dryad_forest_blessing.Description;
		this.m.Icon = "skills/ssu_dryad_forest_blessing.png";
		this.m.IconDisabled = "skills/ssu_dryad_forest_blessing_sw.png";
		this.m.Overlay = "ssu_dryad_buff_active";
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
			text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_dryad_forest_blessing.Tooltip1, this.m.MaxRange)
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_dryad_forest_blessing.Tooltip2
		});
		ret.push({
			id = 9,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = ::Mod_Sellswords.Strings.ssu_dryad_forest_blessing.Tooltip3
		});
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = ::Mod_Sellswords.Strings.ssu_dryad_forest_blessing.Tooltip4
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = ::Mod_Sellswords.Strings.ssu_dryad_forest_blessing.Tooltip5
		});
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = ::Mod_Sellswords.Strings.ssu_dryad_forest_blessing.Tooltip6
		});

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_dryad_forest_blessing.Tooltip7, ammo)
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.ssu_dryad_forest_blessing.Tooltip8
			});
		}

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.ssu_dryad_forest_blessing.Tooltip9
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
		local effect = target.getSkills().getSkillByID("effects.ssu_dryad_forest_blessing_effect");

		if (effect != null)
			effect.resetTime();
		else
			target.getSkills().add(this.new("scripts/skills/effects/ssu_dryad_forest_blessing_effect"));

		this.consumeAmmo();
		return true;
	}

});