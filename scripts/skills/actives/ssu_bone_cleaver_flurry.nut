this.ssu_bone_cleaver_flurry <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.ssu_bone_cleaver_flurry";
		this.m.Name = "Mince";
		this.m.Description = "A continuous flurry of blows so oppressive that it will send anything that survives reeling.";	
		this.m.KilledString = "Cleaved";
		this.m.Icon = "skills/active_182.png";
		this.m.IconDisabled = "skills/active_182_sw.png";
		this.m.Overlay = "active_182";
		this.m.SoundOnUse = [
			"sounds/combat/cleave_01.wav",
			"sounds/combat/cleave_02.wav",
			"sounds/combat/cleave_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/cleave_hit_hitpoints_01.wav",
			"sounds/combat/cleave_hit_hitpoints_02.wav",
			"sounds/combat/cleave_hit_hitpoints_03.wav"
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
		this.m.Delay = 1000;		
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.35;
		this.m.ActionPointCost = 8;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 75;
		this.m.ChanceDisembowel = 75;
		this.m.ChanceSmash = 0;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		local dmg = this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5;

		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will make five separate strikes for [color=%negative%]50%[/color] of the weapon\'s damage each."
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a higher than normal chance to cause fatalities."
			}
		]);
		ret.push({
			id = 9,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts additional stacking [color=%damage%]" + dmg + "[/color] bleeding damage per turn."
		});

		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInCleavers ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
		local target = _targetTile.getEntity();
		local ret = this.attackEntity(_user, target);
		local hp = target.getHitpoints();

		if (this.Tactical.TurnSequenceBar.getActiveEntity().getID() == _user.getID() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
		{
			this.m.IsDoingAttackMove = false;
			this.getContainer().setBusy(true);

			for (local i = 0; i < 4; i++) // 4 attacks
			{
				this.Time.scheduleEvent(this.TimeUnit.Virtual, 200 + (i * 50), function ( _skill )
				{
					if (target.isAlive())
						_skill.attackEntity(_user, target);

					if (i == 3) // On the 4th attack, unlock char
					{
						_skill.m.IsDoingAttackMove = true;
						_skill.getContainer().setBusy(false);
					}
				}.bindenv(this), this);
			}
		}
		else
		{
			for (local i = 0; i < 4; i++)
				if (target.isAlive())
					ret = this.attackEntity(_user, target) || ret;
		}

		if (!target.isAlive() || target.isDying() || !target.getCurrentProperties().IsImmuneToBleeding && hp - target.getHitpoints() >= this.Const.Combat.MinDamageToApplyBleeding)
		{
			local effect = this.new("scripts/skills/effects/bleeding_effect");
			effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5);
			effect.m.bleed_type = 100;
			target.getSkills().add(effect);
		}

		return ret; // 5th attack
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageTotalMult *= 0.5;
			_properties.DamageTooltipMinMult *= 5.0;
			_properties.DamageTooltipMaxMult *= 5.0;
		}
	}

});