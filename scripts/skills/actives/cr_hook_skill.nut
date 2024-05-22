this.cr_hook_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.cr_hook_skill";
		this.m.Name = "Hook";
		this.m.Description = "A target 2 tiles away is hooked and pulled close if there is space. Anyone hit will be staggered and lose initiative. A target can not be pulled up a level of height, but may take damage if it is pulled down several levels of height at once. Shieldwall, Spearwall and Riposte will be canceled for a successfully hooked-in target. A rooted target can not be hooked.";
		this.m.Icon = "skills/active_31.png";
		this.m.IconDisabled = "skills/active_31_sw.png";
		this.m.Overlay = "active_31";
		this.m.SoundOnUse = [
			"sounds/combat/hook_01.wav",
			"sounds/combat/hook_02.wav",
			"sounds/combat/hook_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/hook_hit_01.wav",
			"sounds/combat/hook_hit_02.wav",
			"sounds/combat/hook_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.HitChanceBonus = 10;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 25;
		this.m.MinRange = 2;
		this.m.MaxRange = 2;
	}
	
	function isHidden()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon == null || weapon.getRangeMax() != 2 || !weapon.isItemType(this.Const.Items.ItemType.TwoHanded) || !weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon) || this.getContainer().hasSkill("actives.hook");		
	}	

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]2[/color] tiles"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] chance to stagger on a hit"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] chance to hit"
		});
		return ret;
	}

	function findTileToKnockBackTo( _userTile, _targetTile )
	{
		return this.getPulledToTile(_userTile, _targetTile);
	}

	function getPulledToTile( _userTile, _targetTile )
	{
		local dir = _targetTile.getDirectionTo(_userTile);

		if (_targetTile.hasNextTile(dir))
		{
			local tile = _targetTile.getNextTile(dir);

			if (tile.Level <= _userTile.Level && tile.IsEmpty)
			{
				return tile;
			}
		}

		dir = dir - 1 >= 0 ? dir - 1 : 5;

		if (_targetTile.hasNextTile(dir))
		{
			local tile = _targetTile.getNextTile(dir);

			if (tile.getDistanceTo(_userTile) == 1 && tile.Level <= _userTile.Level && tile.IsEmpty)
			{
				return tile;
			}
		}

		dir = _targetTile.getDirectionTo(_userTile);
		dir = dir + 1 <= 5 ? dir + 1 : 0;

		if (_targetTile.hasNextTile(dir))
		{
			local tile = _targetTile.getNextTile(dir);

			if (tile.getDistanceTo(_userTile) == 1 && tile.Level <= _userTile.Level && tile.IsEmpty)
			{
				return tile;
			}
		}

		return null;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInPolearms ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.ActionPointCost = _properties.IsSpecializedInPolearms ? 5 : 6;
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

		local pulledTo = this.getPulledToTile(_originTile, _targetTile);

		if (pulledTo == null)
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		if (this.Math.rand(1, 100) > this.getHitchance(target))
		{
			return false;
		}

		local pullToTile = this.getPulledToTile(_user.getTile(), _targetTile);

		if (pullToTile == null)
		{
			return false;
		}

		if (target.getCurrentProperties().IsImmuneToKnockBackAndGrab)
		{
			return false;
		}

		if (!_user.isHiddenToPlayer() && pullToTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " hooks in " + this.Const.UI.getColorizedEntityName(target));
		}

		local skills = target.getSkills();
		skills.removeByID("effects.shieldwall");
		skills.removeByID("effects.spearwall");
		skills.removeByID("effects.riposte");

		if (this.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		target.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));

		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has staggered " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
		}

		local overwhelm = this.getContainer().getSkillByID("perk.overwhelm");

		if (overwhelm != null)
		{
			overwhelm.onTargetHit(this, target, this.Const.BodyPart.Body, 0, 0);
		}

		target.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		local damage = this.Math.max(0, this.Math.abs(pullToTile.Level - _targetTile.Level) - 1) * this.Const.Combat.FallingDamage;
		local tag = {
			Attacker = _user,
			Skill = this,
			HitInfo = clone this.Const.Tactical.HitInfo
		};

		if (damage == 0)
		{
			this.Tactical.getNavigator().teleport(_targetTile.getEntity(), pullToTile, this.onHookingComplete, tag, true);
		}
		else
		{
			tag.HitInfo.DamageRegular = damage;
			tag.HitInfo.DamageFatigue = this.Const.Combat.FatigueReceivedPerHit;
			tag.HitInfo.DamageDirect = 1.0;
			tag.HitInfo.BodyPart = this.Const.BodyPart.Body;
			this.Tactical.getNavigator().teleport(target, pullToTile, this.onPulledDown, tag, true);
		}

		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += 10;
		}
	}

	function onPulledDown( _entity, _tag )
	{
		_entity.onDamageReceived(_tag.Attacker, _tag.Skill, _tag.HitInfo);
	}

	function onHookingComplete( _entity, _tag )
	{
		_tag.Attacker.setDirty(true);
	}

});

