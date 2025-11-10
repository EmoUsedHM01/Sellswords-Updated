this.earth_hammer_smite_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.earth_hammer_smite";
		this.m.Name = "Nature's Wrath";
		this.m.Description = "A powerful overhead strike performed with full force to smash a target and their surroundings to bits. Anyone hit will be staggered and lose initiative.";
		this.m.KilledString = "Crushed";
		this.m.Icon = "skills/earth_hammer_smite.png";
		this.m.IconDisabled = "skills/earth_hammer_smite_bw.png";
		this.m.Overlay = "active_122";
		this.m.SoundOnUse = [
			"sounds/combat/smash_01.wav",
			"sounds/combat/smash_02.wav",
			"sounds/combat/smash_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/smash_hit_01.wav",
			"sounds/combat/smash_hit_02.wav",
			"sounds/combat/smash_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsAOE = true;
		this.m.IsIgnoredAsAOO = false;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.5;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 99;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=%positive%]100%[/color] chance to stagger on a hit."
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Unleashes a powerful shockwave on hit to all enemies in adjacent tiles to the target."
		});

		return ret;
	}

	function onAfterUpdate(_properties)
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInHammers ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse(_user, _targetTile)
	{
		this.Tactical.spawnAttackEffect("uproot", _targetTile, 0, -50, 100, 300, 100, this.createVec(0, 80), 200, this.createVec(0, -80), true);
		local target = _targetTile.getEntity();
		local success = this.attackEntity(_user, target);

		if (!_user.isAlive() || _user.isDying())
			return success;

		if (success && _targetTile.IsOccupiedByActor && !target.isNonCombatant() && target.isAlive() && !target.isDying())
		{
			target.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has staggered " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
		}

		for (local i = 0; i < this.Const.Tactical.DustParticles.len(); i = ++i)
			this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[i].Brushes, _targetTile, this.Const.Tactical.DustParticles[i].Delay, this.Const.Tactical.DustParticles[i].Quantity * 0.5, this.Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.5, this.Const.Tactical.DustParticles[i].SpawnRate, this.Const.Tactical.DustParticles[i].Stages, this.createVec(0, -30));

		if (_targetTile.IsOccupiedByActor && _targetTile.getEntity().isAttackable() && !_targetTile.getEntity().isAlliedWith(_user))
		{
			if (_targetTile.getEntity().m.IsShakingOnHit)
			{
				this.Tactical.getShaker().shake(_targetTile.getEntity(), _targetTile, 7);
				_user.playSound(this.Const.Sound.ActorEvent.Move, 2.0);
			}
		}

		for (local i = 0; i < 6; i = ++i)
		{
			if (!_targetTile.hasNextTile(i))
				continue;

			local adjacentTile = _targetTile.getNextTile(i);

			if (adjacentTile.IsOccupiedByActor && adjacentTile.getEntity().isAttackable() && !adjacentTile.getEntity().isAlliedWith(_user))
			{
				this.Tactical.spawnAttackEffect("uproot", adjacentTile, 0, -50, 100, 300, 100, this.createVec(0, 80), 200, this.createVec(0, -80), true);

				for (local j = 0; j < this.Const.Tactical.DustParticles.len(); j = ++j)
				{
					this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[j].Brushes, adjacentTile, this.Const.Tactical.DustParticles[j].Delay, this.Const.Tactical.DustParticles[j].Quantity * 0.5, this.Const.Tactical.DustParticles[j].LifeTimeQuantity * 0.5, this.Const.Tactical.DustParticles[j].SpawnRate, this.Const.Tactical.DustParticles[j].Stages, this.createVec(0, -30));
				}

				if (adjacentTile.getEntity().m.IsShakingOnHit)
				{
					this.Tactical.getShaker().shake(adjacentTile.getEntity(), adjacentTile, 7);
					_user.playSound(this.Const.Sound.ActorEvent.Move, 2.0);
				}

				local _targetEntity = adjacentTile.getEntity();
				local properties = this.m.Container.buildPropertiesForUse(this, _targetEntity);
				properties.DamageTotalMult *= 0.5;
				local info = {
					Skill = this,
					Container = this.getContainer(),
					User = _user,
					TargetEntity = _targetEntity,
					Properties = properties,
					DistanceToTarget = _user.getTile().getDistanceTo(_targetEntity.getTile())
				};
				this.onScheduledTargetHit(info);
			}
		}

		return success;
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties)
	{
		if (_skill == this)
		{
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 20;
		}
	}

});