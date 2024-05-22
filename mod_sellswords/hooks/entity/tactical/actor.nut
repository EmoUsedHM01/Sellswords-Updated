::mods_hookExactClass("entity/tactical/actor", function(o)
{
	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
		this.getSkills().add(this.new("scripts/skills/effects/crbolstered_effect"));
		this.getSkills().add(this.new("scripts/skills/effects/ptr_armor_fatigue_recovery_effect"));
	}
	
	o.onOtherActorDeath = function ( _killer, _victim, _skill )
	{
		if (!this.m.IsAlive || this.m.IsDying)
		{
			return;
		}			
		if (_victim.getXPValue() <= 1)
		{
			return;
		}
		if (_victim.getType() == this.Const.EntityType.Wardog || _victim.getType() == this.Const.EntityType.Warhound)
		{			
			return;
		}			
		if (_victim.getFaction() == this.getFaction() && _victim.getCurrentProperties().TargetAttractionMult > 0.5 && this.getCurrentProperties().IsAffectedByDyingAllies)
		{
			local difficulty = this.Const.Morale.AllyKilledBaseDifficulty - _victim.getXPValue() * this.Const.Morale.AllyKilledXPMult + this.Math.pow(_victim.getTile().getDistanceTo(this.getTile()), this.Const.Morale.AllyKilledDistancePow);
			if (_killer != null)
			{
				difficulty = this.Math.floor((this.Const.Morale.AllyKilledBaseDifficulty - _victim.getXPValue() * this.Const.Morale.AllyKilledXPMult + this.Math.pow(_victim.getTile().getDistanceTo(this.getTile()), this.Const.Morale.AllyKilledDistancePow)) * _killer.getPercentOnKillOtherActorModifier()) + _killer.getFlatOnKillOtherActorModifier();
			}
			this.checkMorale(-1, difficulty, this.Const.MoraleCheckType.Default, "", true);
		}
		else if (this.getAlliedFactions().find(_victim.getFaction()) == null)
		{
			local difficulty = this.Const.Morale.EnemyKilledBaseDifficulty + _victim.getXPValue() * this.Const.Morale.EnemyKilledXPMult - this.Math.pow(_victim.getTile().getDistanceTo(this.getTile()), this.Const.Morale.EnemyKilledDistancePow);
			if (_killer != null && _killer.isAlive() && _killer.getID() == this.getID())
			{
				difficulty = difficulty + this.Const.Morale.EnemyKilledSelfBonus;
			}
			this.checkMorale(1, difficulty);
		}			
	}

	o.onMovementInZoneOfControl = function( _entity, _isOnEnter )
	{		
		if (!this.m.IsActingEachTurn)
		{
			return false;
		}

		if (!this.m.IsUsingZoneOfControl || !this.m.IsExertingZoneOfControl)
		{
			return false;
		}

		if (this.m.MoraleState == this.Const.MoraleState.Fleeing || this.getCurrentProperties().IsStunned)
		{
			return false;
		}

		local reachadvantage = this.m.Skills.getSkillByID("perk.crReachadvantage");
		local spearwall = false;	
		if (reachadvantage != null && reachadvantage.m.Opponents.find(_entity.getID()) != null)
		{
			spearwall = true;  //if true, attack when entering ZOC
		}		
		if (_isOnEnter && !spearwall && (!this.getCurrentProperties().IsAttackingOnZoneOfControlEnter || !this.getCurrentProperties().IsAttackingOnZoneOfControlAlways && this.getTile().getZoneOfControlCountOtherThan(this.getAlliedFactions()) > 1))
		{
			return false;
		}
		if (!_entity.getCurrentProperties().IsImmuneToZoneOfControl && !_entity.isAlliedWith(this))
		{
			local skill = this.m.Skills.getAttackOfOpportunity();

			if (skill != null)
			{
				return true;
			}
		}
		return false;
	}

	o.onAttackOfOpportunity = function( _entity, _isOnEnter )
	{	
		if (!this.m.IsActingEachTurn)
		{
			return false;
		}

		if (!this.m.IsUsingZoneOfControl || !this.m.IsExertingZoneOfControl)
		{
			return false;
		}

		if (this.m.MoraleState == this.Const.MoraleState.Fleeing || this.getCurrentProperties().IsStunned)
		{
			return false;
		}

		local reachadvantage = this.m.Skills.getSkillByID("perk.crReachadvantage");
		local spearwall = false;
		if (reachadvantage != null && reachadvantage.m.Opponents.find(_entity.getID()) != null)
		{
			spearwall = true;  //if true, attack when entering ZOC
		}			
		if (_isOnEnter && !spearwall && (!this.getCurrentProperties().IsAttackingOnZoneOfControlEnter || !this.getCurrentProperties().IsAttackingOnZoneOfControlAlways && this.getTile().getZoneOfControlCountOtherThan(this.getAlliedFactions()) > 1))
		{
			return false;
		}

		if (_entity.getTile().Properties.Effect != null && _entity.getTile().Properties.Effect.Type == "smoke")
		{
			return false;
		}

		if (!_entity.getCurrentProperties().IsImmuneToZoneOfControl && !_entity.isAlliedWith(this))
		{
			local skill = this.m.Skills.getAttackOfOpportunity();

			if (skill != null)
			{
				if (skill.useForFree(_entity.getTile()))
				{
					_entity.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
					return true;
				}
			}
		}

		return false;
	}
	
});
