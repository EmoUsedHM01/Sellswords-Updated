this.grass_slash <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.grass_slash";
		this.m.Name = "Nature's Slash";
		this.m.Description = "A swift slashing attack dealing average damage. Inflicts poison and rooted on the target.";
		this.m.KilledString = "Cut down";
		this.m.Icon = "skills/grass_slash.png";
		this.m.IconDisabled = "skills/grass_slash_sw.png";
		this.m.SoundOnUse = [
			"sounds/combat/slash_01.wav",
			"sounds/combat/slash_02.wav",
			"sounds/combat/slash_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/slash_hit_01.wav",
			"sounds/combat/slash_hit_02.wav",
			"sounds/combat/slash_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.HitChanceBonus = 10;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 50;
		this.m.ChanceDisembowel = 33;
		this.m.ChanceSmash = 0;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.HitChanceBonus + "%[/color] chance to hit"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts the Poisoned status effect on hit"
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts the Rooted status effect on hit"
		});
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInSwords ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSlash);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += 10;
			_skill.resetField("HitChanceBonus");

			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
			{
				_properties.MeleeSkill += 5;
				this.m.HitChanceBonus += 5;
			}
		}
	}
	
	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor();
		
		if (!actor.isAlive() || actor.isDying())
		{
			return;
		}

		if (!_targetEntity.isAlive() || _targetEntity.isDying())
		{
			return;
		}
		
		local breakFree = this.new("scripts/skills/actives/break_free_skill");
		_targetEntity.getSkills().add(this.new("scripts/skills/effects/rooted_effect"));
		breakFree.setDecal("roots_destroyed");
		breakFree.m.Icon = "skills/active_75.png";
		breakFree.m.IconDisabled = "skills/active_75_sw.png";
		breakFree.m.Overlay = "active_75";
		breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;
		_targetEntity.getSkills().add(breakFree);
		_targetEntity.raiseRootsFromGround("bust_roots", "bust_roots_back");

		if (_targetEntity.getFlags().has("undead"))
		{
			return;
		}

		if (_targetEntity.getCurrentProperties().IsImmuneToPoison || _targetEntity.getHitpoints() <= 0)
		{
			return;
		}

		if (!_targetEntity.isHiddenToPlayer())
		{
			local poisonSound = [
				"sounds/combat/poison_applied_01.wav",
				"sounds/combat/poison_applied_02.wav"
			];
			this.Sound.play(poisonSound[this.Math.rand(0, poisonSound.len() - 1)], this.Const.Sound.Volume.Actor, _targetEntity.getPos());
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is poisoned");
		}

		local gobboPoison = _targetEntity.getSkills().getSkillByID("effects.goblin_poison");
		if (gobboPoison == null)
		{
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/goblin_poison_effect"));
		}
		else
		{
			gobboPoison.resetTime();
		}
	}

});

