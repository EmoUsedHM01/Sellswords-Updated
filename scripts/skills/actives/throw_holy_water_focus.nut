this.throw_holy_water_focus <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.throw_holy_water_focus";
		this.m.Name = "Targeted Throw Blessed Water";
		this.m.Description = "Throw a flask of blessed water towards a target, where it will shatter and spray its contents. The blessed water will burn the undead, but will not affect other targets.";
		this.m.Icon = "skills/active_cr_01.png";
		this.m.IconDisabled = "skills/active_cr_01_sw.png";
		this.m.Overlay = "active_97";
		this.m.SoundOnUse = [
			"sounds/combat/throw_ball_01.wav",
			"sounds/combat/throw_ball_02.wav",
			"sounds/combat/throw_ball_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/acid_flask_impact_01.wav",
			"sounds/combat/acid_flask_impact_02.wav",
			"sounds/combat/acid_flask_impact_03.wav",
			"sounds/combat/acid_flask_impact_04.wav"
		];
		this.m.SoundOnHitDelay = 0;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 0;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsOffensiveToolSkill = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = true;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 3;
		this.m.ProjectileType = this.Const.ProjectileType.Flask2;
		this.m.ProjectileTimeScale = 1.5;
		this.m.IsProjectileRotated = false;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		local ammo = this.getAmmo();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "Inflicts at least [color=%damage%]30[/color] damage to hitpoints for [color=%damage%]3[/color] turns, all of which ignores armor"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=%positive%]" + this.getMaxRange() + "[/color] tiles"
		});			
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Only affects undead targets"
		});
		
		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=%positive%]" + ammo + "[/color] bottle of holy water left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]No bottles of holy water left[/color]"
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
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (item == null)
		{
			return 0;
		}

		return item.getAmmo();
	}

	function consumeAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (item != null)
		{
			item.consumeAmmo();
		}
	}
	
	function applyEffect( _target )
	{
		if (!_target.getFlags().has("undead"))
		{
			return;
		}

		local poison = _target.getSkills().getSkillByID("effects.holy_water");

		if (poison == null)
		{
			local hwe = this.new("scripts/skills/effects/holy_water_effect");
			hwe.m.Concentrate = true;
			_target.getSkills().add(hwe);
		}
		else
		{
			poison.resetTime();
		}
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (_originTile.Level + 1 < _targetTile.Level)
		{
			return false;
		}

		return true;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = (_properties.IsSpecializedInThrowing || _properties.IsSpecializedInNets) ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.MaxRange = _properties.IsSpecializedInNets ? 4 : 3;
	}

	function onUse( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();

		if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
		{
			local flip = !this.m.IsProjectileRotated && targetEntity.getPos().X > _user.getPos().X;

			if (_user.getTile().getDistanceTo(targetEntity.getTile()) >= this.Const.Combat.SpawnProjectileMinDist)
			{
				this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), targetEntity.getTile(), 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			}
		}

		this.consumeAmmo();
	}

	function onApplyEffect( _data )
	{
		local targetEntity = _data.TargetTile.getEntity();

		if (_data.Skill.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(_data.Skill.m.SoundOnHit[this.Math.rand(0, _data.Skill.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, targetEntity.getPos());
		}

		_data.Skill.applyEffect(targetEntity);
	}

});

