this.perk_crTrumpcard <- this.inherit("scripts/skills/skill", {
	m = {
		Opponents = []
	},
	function create()
	{
		this.m.ID = "perk.crTrumpcard";
		this.m.Name = this.Const.Strings.PerkName.crTrumpcard;
		this.m.Description = this.Const.Strings.PerkDescription.crTrumpcard;
		this.m.Icon = "skills/status_effect_06.png";
		this.m.IconMini = "status_effect_06_mini";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.Opponents.len() == 0;
	}

	function getOpponentEntry(_entityID)
	{
		foreach (opponentEntry in this.m.Opponents)
		{
			if (opponentEntry == _entityID)
			{
				return opponentEntry;
			}
		}

		return null;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push(
			{
				id = 10,
				type = "text",
				icon = "ui/icons/plus.png",
				text = "Distract them"
			}
		);		

		foreach (opponentEntry in this.m.Opponents)
		{
			local opponent = this.Tactical.getEntityByID(opponentEntry);
			if (opponent == null || !opponent.isPlacedOnMap() || !opponent.isAlive() || opponent.isDying())
			{
				continue;
			}

			tooltip.push(
				{
					id = 10,
					type = "text",
					icon = "ui/orientation/" + opponent.getOverlayImage() + ".png",
					text = "Have already distracted " + opponent.getName()
				}
			);
		}

		return tooltip;
	}

	function procIfApplicable(_entity, _skill)
	{
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap() || actor.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return;
		}

		if (_skill == null || !_skill.isAttack() || _entity == null || _entity.isAlliedWith(actor))
		{
			return;
		}

		foreach (opponentEntry in this.m.Opponents)
		{
			if (opponentEntry == _entity.getID())
			{
				return;
			}
		}

		this.m.Opponents.push(_entity.getID());
	}

	function onUpdate( _properties )
	{
		for (local i = this.m.Opponents.len() - 1; i >= 0; i--)
		{
			local e = this.Tactical.getEntityByID(this.m.Opponents[i]);
			if (e == null || !e.isAlive())
			{
				this.m.Opponents.remove(i);
			}
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.isDying())
		{
			return;
		}
			
		if (_targetEntity != null && _skill != null && !_skill.isRanged() && _skill.isAttack())
		{
			local opponentEntry = this.getOpponentEntry(_targetEntity.getID());
			if (opponentEntry == null)
			{
				_targetEntity.getSkills().add(this.new("scripts/skills/effects/crdistracted_effect"));
			}
		}			

		this.procIfApplicable(_targetEntity, _skill);			
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		if (_targetEntity == null)
			return;

		if (_targetEntity.isAttackable())
			return;
			
		if (_skill != null && !_skill.isRanged() && _skill.isAttack())
		{
			local opponentEntry = this.getOpponentEntry(_targetEntity.getID());
			if (opponentEntry == null)
			{
				_targetEntity.getSkills().add(this.new("scripts/skills/effects/crdistracted_effect"));
			}
		}	
		this.procIfApplicable(_targetEntity, _skill);		
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Opponents.clear();
	}
});
