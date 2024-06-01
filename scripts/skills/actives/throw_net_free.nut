this.throw_net_free <- this.inherit("scripts/skills/skill", {
	m = {
		HasUsed = false,
		IsReinforced = false
	},

	function create()
	{
		this.m.ID = "actives.throw_net_free";
		this.m.Name = "Throw Portable Net";
		this.m.Description = "Throw a net on your target in order to prevent them from moving or defending themself effectively.";
		this.m.Icon = "skills/active_073.png";
		this.m.IconDisabled = "skills/active_073_sw.png";
		this.m.Overlay = "active_73";
		this.m.SoundOnUse = [
			"sounds/combat/throw_net_01.wav",
			"sounds/combat/throw_net_02.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/break_free_net_01.wav",
			"sounds/combat/break_free_net_02.wav",
			"sounds/combat/break_free_net_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 0;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsOffensiveToolSkill = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 5;
		this.m.MaxLevelDifference = 1;
	}
	
	function isUsable()
	{
		if (!this.m.HasUsed)
		{
			return true;
		}

		return false;
	}	

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getMaxRange() + "[/color] tiles"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Some targets can never be caught or ensnared"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Can be used once per battle"
			}			
		]);
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInNets ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_net_repair"))
		{
			this.m.ActionPointCost = 3;		
		}
		if (::Is_PTR_Exist)
		{
			if (this.getContainer().getActor().getSkills().hasSkill("perk.ptr_offhand_training"))
			{
				this.m.ActionPointCost = 0;		
			}	
		}
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (_targetTile.getEntity().getCurrentProperties().IsRooted)
		{
			return false;
		}

		return true;
	}

	function onNetSpawn( _data )
	{
		local rooted = _data.TargetEntity.getSprite("status_rooted");
		rooted.setBrush("bust_net");
		rooted.Visible = true;
		local rooted_back = _data.TargetEntity.getSprite("status_rooted_back");
		rooted_back.setBrush("bust_net_back");
		rooted_back.Visible = true;
		_data.TargetEntity.setDirty(true);
	}

	function onUse( _user, _targetTile )
	{
		this.m.HasUsed = true;
		local targetEntity = _targetTile.getEntity();
		local rd = this.Math.rand(1, 100);
		local crrd = targetEntity.getSkills().hasSkill("perk.crrangeddefense") ? this.Math.rand(1, 100) <= targetEntity.getBaseProperties().RangedDefense : false;
		local escapeartist = targetEntity.getSkills().hasSkill("perk.legend_escape_artist") ? this.Math.rand(1, 100) <= targetEntity.getBaseProperties().RangedDefense : false;		

		if (_user.getSkills().hasSkill("perk.legend_net_casting"))
		{
			rd *= 0.5;
		}

		if (_user.getSkills().hasSkill("perk.legend_net_repair"))
		{
			rd *= 0.75;
		}

		if (rd > this.getHitchance(_targetTile.getEntity()))
		{
			targetEntity.onMissed(this.getContainer().getActor(), this);
			return false;
		}
		else if (!targetEntity.getCurrentProperties().IsImmuneToRoot && !crrd && !escapeartist)
		{
			if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, targetEntity.getPos());
			}

			targetEntity.getSkills().add(this.new("scripts/skills/effects/net_effect"));
			local breakFree = this.new("scripts/skills/actives/break_free_skill");
			breakFree.m.Icon = "skills/active_74.png";
			breakFree.m.IconDisabled = "skills/active_74_sw.png";
			breakFree.m.Overlay = "active_74";
			breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;

			breakFree.setDecal("net_destroyed");
			breakFree.setChanceBonus(0);

			targetEntity.getSkills().add(breakFree);
			local effect = this.Tactical.spawnSpriteEffect("bust_net", this.createColor("#ffffff"), _targetTile, 0, 10, 1.0, targetEntity.getSprite("status_rooted").Scale, 100, 100, 0);
			local flip = !targetEntity.isAlliedWithPlayer();
			effect.setHorizontalFlipping(flip);
			this.Time.scheduleEvent(this.TimeUnit.Real, 200, this.onNetSpawn.bindenv(this), {
				TargetEntity = targetEntity,
				IsReinforced = false
			});
		}
		else
		{
			if (this.m.SoundOnMiss.len() != 0)
			{
				this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], this.Const.Sound.Volume.Skill, targetEntity.getPos());
			}

			return false;
		}
	}
	
	function onCombatStarted()
	{
		this.m.HasUsed = false;			
	}	

});

