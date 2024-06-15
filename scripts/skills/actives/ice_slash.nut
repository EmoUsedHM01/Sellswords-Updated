this.ice_slash <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.ice_slash";
		this.m.Name = "Ebonice Slash";
		this.m.Description = "A swift slashing attack dealing average damage. Inflicts the chilled and staggered debuffs the target.";
		this.m.KilledString = "Cut down";
		this.m.Icon = "skills/ice_slash.png";
		this.m.IconDisabled = "skills/ice_slash_sw.png";
		this.m.SoundOnUse = [
			"sounds/combat/slash_01.wav",
			"sounds/combat/slash_02.wav",
			"sounds/combat/slash_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/ice_sword_impact.wav"
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
		this.m.FatigueCost = 15;
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
			text = "Inflicts the Chilled status effect on hit"
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts the Staggered status effect on hit"
		});
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInGreatSwords ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
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

			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInGreatSwords)
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

		if (!_targetEntity.isHiddenToPlayer())
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is chilled");
		}
		
		_targetEntity.getSkills().add(this.new("scripts/skills/effects/chilled_effect"));
		_targetEntity.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));
	}

});

