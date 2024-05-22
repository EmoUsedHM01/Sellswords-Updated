this.throw_acid_flask_02 <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.throw_acid_flask_02";
		this.m.Name = "Throw Acid Flask";
		this.m.Description = "Throw a flask of acid towards a target, where it will shatter and spray its contents. The acid will slowly corrode away any armor of those hit - friend and foe alike.";
		this.m.Icon = "skills/active_cr_03.png";
		this.m.IconDisabled = "skills/active_106_sw.png";
		this.m.Overlay = "active_106";
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
		this.m.ProjectileType = this.Const.ProjectileType.Flask;
		this.m.ProjectileTimeScale = 1.5;
		this.m.IsProjectileRotated = false;
	}
	
	function isHidden()
	{
		return this.getContainer().getActor().getCurrentProperties().IsSpecializedInNets;
	}	

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces the target\'s armor by [color=" + this.Const.UI.Color.DamageValue + "]25%[/color] each turn for 3 turns."
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=" + this.Const.UI.Color.DamageValue + "]33%[/color] chance to hit bystanders at the same or lower height level as well."
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Lasts for at least [color=" + this.Const.UI.Color.PositiveValue + "]" + 2 + "[/color] turns"
		});		
		return ret;
	}

	function applyAcid( _target )
	{
		if (_target.getFlags().has("lindwurm"))
		{
			return;
		}

		if ((_target.getFlags().has("body_immune_to_acid") || _target.getArmor(this.Const.BodyPart.Body) <= 0) && (_target.getFlags().has("head_immune_to_acid") || _target.getArmor(this.Const.BodyPart.Head) <= 0))
		{
			return;
		}

		local poison = _target.getSkills().getSkillByID("effects.acid_strong");

		if (poison == null)
		{
			_target.getSkills().add(this.new("scripts/skills/effects/acid_effect_strong"));
		}
		else
		{
			poison.resetTime();
		}

		this.spawnIcon("status_effect_78", _target.getTile());
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
		this.m.FatigueCostMult = _properties.IsSpecializedInThrowing ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
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

		_user.getItems().unequip(_user.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
		this.Time.scheduleEvent(this.TimeUnit.Real, 200, this.onApplyAcid.bindenv(this), {
			Skill = this,
			TargetTile = _targetTile
		});
	}

	function onApplyAcid( _data )
	{
		local targetEntity = _data.TargetTile.getEntity();

		if (_data.Skill.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(_data.Skill.m.SoundOnHit[this.Math.rand(0, _data.Skill.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, targetEntity.getPos());
		}

		_data.Skill.applyAcid(targetEntity);

		for( local i = 0; i < 6; i = ++i )
		{
			if (!_data.TargetTile.hasNextTile(i))
			{
			}
			else
			{
				local nextTile = _data.TargetTile.getNextTile(i);

				if (this.Math.rand(1, 100) > 33)
				{
				}
				else if (nextTile.Level > _data.TargetTile.Level)
				{
				}
				else if (!nextTile.IsOccupiedByActor)
				{
					for( local i = 0; i < this.Const.Tactical.AcidParticles.len(); i = ++i )
					{
						this.Tactical.spawnParticleEffect(true, this.Const.Tactical.AcidParticles[i].Brushes, nextTile, this.Const.Tactical.AcidParticles[i].Delay, this.Const.Tactical.AcidParticles[i].Quantity, this.Const.Tactical.AcidParticles[i].LifeTimeQuantity, this.Const.Tactical.AcidParticles[i].SpawnRate, this.Const.Tactical.AcidParticles[i].Stages);
					}
				}
				else
				{
					local entity = nextTile.getEntity();
					_data.Skill.applyAcid(entity);
				}
			}
		}
	}

});

