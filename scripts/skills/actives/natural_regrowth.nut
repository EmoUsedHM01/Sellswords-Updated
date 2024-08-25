this.natural_regrowth <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.natural_regrowth";
		this.m.Name = "Natural Regrowth";
		this.m.Description = "Heals a friendly unit, removing all fresh injuries and healing up to 60 health per use. Can not be used while engaged in melee.";
		this.m.Icon = "skills/dryad_natural_regrowth.png";
		this.m.IconDisabled = "skills/dryad_natural_regrowth_sw.png";
		this.m.SoundOnUse = [
			"sounds/combat/first_aid_01.wav",
			"sounds/combat/first_aid_02.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 15;
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
			text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.MaxRange + "[/color], can only target damaged units."
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/health.png",
			text = "You can heal up to [color=" + this.Const.UI.Color.PositiveValue + "]60[/color] hitpoints."
		});
		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] charges left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Needs a heart filled with power equipped[/color]"
			});
		}
		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used because this character is engaged in melee[/color]"
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

		if (target.getHitpoints() >= target.getHitpointsMax())
			return false;

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local effect = {
			Delay = 0,
			Quantity = 60,
			LifeTimeQuantity = 60,
			SpawnRate = 50,
			Brushes = [
			"effect_leaf_001"
			],
		Stages = [
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.8,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 30,
				VelocityMax = 50,
				DirectionMin = this.createVec(-0.5, 0.4),
				DirectionMax = this.createVec(0.5, 0.4),
				SpawnOffsetMin = this.createVec(-30, -30),
				SpawnOffsetMax = this.createVec(30, 0)
			},
			{
				LifeTimeMin = 1.4,
				LifeTimeMax = 1.4,
				ColorMin = this.createColor("ffffffff"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 0.5,
				ScaleMax = 0.8,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 70,
				VelocityMax = 140,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.3,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.8,
				VelocityMin = 30,
				VelocityMax = 50,
				ForceMin = this.createVec(0, -60),
				ForceMax = this.createVec(0, -60)
			}
		]};

		this.Tactical.spawnParticleEffect(false, effect.Brushes, _targetTile, effect.Delay, effect.Quantity * 0.5, effect.LifeTimeQuantity * 0.5, effect.SpawnRate, effect.Stages, this.createVec(0, 40));

		local target = _targetTile.getEntity();
		local maxHeal = 60;
		local neededHeal = target.getHitpointsMax() - target.getHitpoints();
		local finalHeal = maxHeal;

		if (neededHeal < maxHeal)
			local finalHeal = neededHeal;

		target.setHitpoints(this.Math.min(target.getHitpointsMax(), target.getHitpoints() + finalHeal));

		if (target.getSkills().hasSkill("racial.dryad"))
		{
			local head = target.getHeadItem();
			local headArmor = head == null ? 1 : head.getArmor();
			local maxHeadArmor = head == null ? 1 : head.getArmorMax();
			local body = target.getBodyItem();
			local bodyArmor = body == null ? 1 : body.getArmor();
			local maxBodyArmor = body == null ? 1 : body.getArmorMax();

			for( local i = 0; i < this.Math.ceil((maxHeadArmor - headArmor + maxBodyArmor - bodyArmor)) && i < 100; i = i )
			{
				if (headArmor + 1 / maxHeadArmor > bodyArmor + 1 / maxBodyArmor)
				{
					body.setArmor(this.Math.minf(maxBodyArmor, bodyArmor + 1));
					bodyArmor = body.getArmor();
				}
				else
				{
					head.setArmor(this.Math.minf(maxHeadArmor, headArmor + 1));
					headArmor = head.getArmor();
				}

				i = ++i;
			}
		}

		if (target.getSkills().query(this.Const.SkillType.TemporaryInjury))
		{
			local injury = target.getSkills().query(this.Const.SkillType.TemporaryInjury);

			foreach( inj in injury )
				inj.removeSelf();
		}

		this.consumeAmmo();

		target.getSkills().update();
		target.setDirty(true);

		return true;
	}

});