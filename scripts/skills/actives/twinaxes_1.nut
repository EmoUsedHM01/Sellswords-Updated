this.twinaxes_1 <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.twinaxes_1";
		this.m.Name = "Hack";
		this.m.Description = "Continuous chopping attack that bears full force on any target.";		
		this.m.KilledString = "Hacked";
		this.m.Icon = "skills/active_25.png";
		this.m.IconDisabled = "skills/active_25_sw.png";
		this.m.Overlay = "active_25";
		this.m.SoundOnUse = [
			"sounds/combat/chop_01.wav",
			"sounds/combat/chop_02.wav",
			"sounds/combat/chop_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/chop_hit_01.wav",
			"sounds/combat/chop_hit_02.wav",
			"sounds/combat/chop_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = false;
		this.m.IsWeaponSkill = true;
		this.m.Delay = 500;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 13;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 25;
		this.m.ChanceDisembowel = 25;
		this.m.ChanceSmash = 0;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		local hc = 2;
		local hd = 70;
		if (this.getContainer().hasSkill("perk.crHackSPM"))
		{
			hc += 1;
			hd -= 10;
		}		
		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will make [color=" + this.Const.UI.Color.PositiveValue + "]" + hc + "[/color] separate strikes for [color=" + this.Const.UI.Color.PositiveValue + "]" + hd + "%[/color] of the weapon\'s damage each"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts additional [color=" + this.Const.UI.Color.PositiveValue + "]35%[/color] damage on a hit to the head"
			}			
		]);
		return ret;
	}
	
	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInAxes ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
		local target = _targetTile.getEntity();
		local ret = this.attackEntity(_user, target);

		if (this.Tactical.TurnSequenceBar.getActiveEntity().getID() == _user.getID() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
		{
			this.m.IsDoingAttackMove = false;
			this.getContainer().setBusy(true);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 200, function ( _skill )
			{
				if (target.isAlive())
				{
					_skill.attackEntity(_user, target);
				}
			}.bindenv(this), this);
			if (this.getContainer().hasSkill("perk.crHackSPM"))
			{
				this.Time.scheduleEvent(this.TimeUnit.Virtual, 400, function ( _skill )
				{
					if (target.isAlive())
					{
						_skill.attackEntity(_user, target);
					}

					_skill.m.IsDoingAttackMove = true;
					_skill.getContainer().setBusy(false);
				}.bindenv(this), this);
			}			
			return true;
		}
		else
		{
			if (target.isAlive())
			{
				ret = this.attackEntity(_user, target) || ret;
			}
			
			if (this.getContainer().hasSkill("perk.crHackSPM"))
			{
				if (target.isAlive())
				{
					ret = this.attackEntity(_user, target) || ret;
				}
			}				

			return ret;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageTotalMult *= 0.7;
			_properties.DamageTooltipMaxMult *= 2.0;
			_properties.DamageAgainstMult[this.Const.BodyPart.Head] += 0.35;
			if (this.getContainer().hasSkill("perk.crHackSPM"))
			{
				_properties.DamageTotalMult *= 0.85;			
				_properties.DamageTooltipMaxMult *= 1.5;
			}			
		}
	}

});

