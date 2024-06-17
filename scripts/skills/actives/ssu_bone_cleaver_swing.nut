this.ssu_bone_cleaver_swing <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.ssu_bone_cleaver_swing";
		this.m.Name = "Swing";
		this.m.Description = "Swinging the weapons in a wide arc that hits three adjacent tiles in counter-clockwise order. Be careful around your own men unless you want to relieve your payroll!";
		this.m.Icon = "skills/active_06.png";
		this.m.IconDisabled = "skills/active_06_sw.png";
		this.m.Overlay = "active_06";
		this.m.SoundOnUse = [
			"sounds/combat/swing_01.wav",
			"sounds/combat/swing_02.wav",
			"sounds/combat/swing_03.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/swing_hit_01.wav",
			"sounds/combat/swing_hit_02.wav",
			"sounds/combat/swing_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsAOE = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.25;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 99;
		this.m.ChanceDisembowel = 50;
		this.m.ChanceSmash = 0;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		local dmg = this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5;

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can hit up to 3 targets"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Will make two separate strikes for [color=" + this.Const.UI.Color.NegativeValue + "]65%[/color] of the weapon\'s damage each"
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts additional stacking [color=" + this.Const.UI.Color.DamageValue + "]" + dmg + "[/color] bleeding damage per turn."
		});

		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] chance to hit"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] chance to hit"
			});
		}

		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInCleavers ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSwing);
		local ret = false;
		local ownTile = _user.getTile();
		local dir = ownTile.getDirectionTo(_targetTile);
		local target = _targetTile.getEntity();

		if (target.isAttackable())
		{
			ret = this.attackEntity(_user, target);
			if (target.isAlive())
			{
				ret = this.attackEntity(_user, target) || ret;
			}
		}

		if (!_user.isAlive() || _user.isDying())
			return ret;

		local nextDir = dir - 1 >= 0 ? dir - 1 : this.Const.Direction.COUNT - 1;

		if (ownTile.hasNextTile(nextDir))
		{
			local nextTile = ownTile.getNextTile(nextDir);
			local firstTarget = nextTile.getEntity();

			if (nextTile.IsOccupiedByActor && firstTarget.isAttackable() && this.Math.abs(nextTile.Level - ownTile.Level) <= 1)
			{
				ret = this.attackEntity(_user, firstTarget) || ret;

				if (firstTarget.isAlive())
					ret = this.attackEntity(_user, firstTarget) || ret;
			}
		}

		if (!_user.isAlive() || _user.isDying())
			return ret;

		nextDir = nextDir - 1 >= 0 ? nextDir - 1 : this.Const.Direction.COUNT - 1;

		if (ownTile.hasNextTile(nextDir))
		{
			local nextTile = ownTile.getNextTile(nextDir);
			local secondTarget = nextTile.getEntity();

			if (nextTile.IsOccupiedByActor && secondTarget.isAttackable() && this.Math.abs(nextTile.Level - ownTile.Level) <= 1)
			{
				ret = this.attackEntity(_user, secondTarget) || ret;

				if (secondTarget.isAlive())
					ret = this.attackEntity(_user, secondTarget) || ret;
			}
		}

		return ret;
	}

	function onTargetSelected( _targetTile )
	{
		local ownTile = this.m.Container.getActor().getTile();
		local dir = ownTile.getDirectionTo(_targetTile);
		this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, _targetTile, _targetTile.Pos.X, _targetTile.Pos.Y);
		local nextDir = dir - 1 >= 0 ? dir - 1 : this.Const.Direction.COUNT - 1;

		if (ownTile.hasNextTile(nextDir))
		{
			local nextTile = ownTile.getNextTile(nextDir);

			if (this.Math.abs(nextTile.Level - ownTile.Level) <= 1)
				this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, nextTile, nextTile.Pos.X, nextTile.Pos.Y);
		}

		nextDir = nextDir - 1 >= 0 ? nextDir - 1 : this.Const.Direction.COUNT - 1;

		if (ownTile.hasNextTile(nextDir))
		{
			local nextTile = ownTile.getNextTile(nextDir);

			if (this.Math.abs(nextTile.Level - ownTile.Level) <= 1)
				this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, nextTile, nextTile.Pos.X, nextTile.Pos.Y);
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor().get();

		if (!actor.isAlive() || actor.isDying())
			return;

		if (!_targetEntity.isAlive() || _targetEntity.isDying())
			return;

		if (!_targetEntity.getCurrentProperties().IsImmuneToBleeding)
		{
			local effect = this.new("scripts/skills/effects/bleeding_effect");
			effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5);
			effect.m.bleed_type = 100;
			_targetEntity.getSkills().add(effect);
		}

		if (!_targetEntity.isHiddenToPlayer())
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is bleeding");
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers)
				_properties.MeleeSkill -= 5;
			else
				_properties.MeleeSkill += 5;

			_properties.DamageTotalMult *= 0.65;
			_properties.DamageTooltipMinMult *= 1.3;
			_properties.DamageTooltipMaxMult *= 1.3;
		}
	}

});