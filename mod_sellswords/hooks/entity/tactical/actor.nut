::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/actor", function ( q ) {

	q.onInit = @(__original) function()
	{
		__original();
		this.getSkills().add(this.new("scripts/skills/effects/crbolstered_effect"));
		this.getSkills().add(this.new("scripts/skills/effects/ptr_armor_fatigue_recovery_effect"));
	}

	q.onOtherActorDeath = @(__original) function ( _killer, _victim, _skill )
	{
		if (!this.m.IsAlive || this.m.IsDying)
			return;

		if (_victim.getXPValue() <= 1)
			return;

		if (_victim.getType() == this.Const.EntityType.Wardog || _victim.getType() == this.Const.EntityType.Warhound)
			return;

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
				difficulty = difficulty + this.Const.Morale.EnemyKilledSelfBonus;

			this.checkMorale(1, difficulty);
		}
	}

	q.onMovementFinish = @(__original) function (_tile) 
	{
		this.m.IsMoving = true;
		this.updateVisibility(_tile, this.m.CurrentProperties.getVision(), this.getFaction());

		if (this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() != this.getID())
			this.Tactical.TurnSequenceBar.getActiveEntity().updateVisibilityForFaction();

		this.setZoneOfControl(_tile, this.hasZoneOfControl());

		if (!this.m.IsExertingZoneOfOccupation) 
		{
			_tile.addZoneOfOccupation(this.getFaction());
			this.m.IsExertingZoneOfOccupation = true;
		}

		if (this.Const.Tactical.TerrainEffect[_tile.Type].len() > 0 && !this.m.Skills.hasSkill(this.Const.Tactical.TerrainEffectID[_tile.Type]))
			this.m.Skills.add(this.new(this.Const.Tactical.TerrainEffect[_tile.Type]));

		if (_tile.IsHidingEntity)
			this.m.Skills.add(this.new(this.Const.Movement.HiddenStatusEffect));

		local numOfEnemiesAdjacentToMe = _tile.getZoneOfControlCountOtherThan(this.getAlliedFactions());

		if (this.m.CurrentMovementType == this.Const.Tactical.MovementType.Default)
		{
			if (this.m.MoraleState != this.Const.MoraleState.Fleeing)
			{
				for (local i = 0; i != 6; i = ++i)
				{
					if (!_tile.hasNextTile(i))
						continue;

					local otherTile = _tile.getNextTile(i);

					if (!otherTile.IsOccupiedByActor)
						continue;

					local otherActor = otherTile.getEntity();
					local numEnemies = otherTile.getZoneOfControlCountOtherThan(otherActor.getAlliedFactions());

					// Check if the actor has the battleheart perk
					if (otherActor.m.MaxEnemiesThisTurn < numEnemies && !otherActor.isAlliedWith(this))
					{
						if (!otherActor.getSkills().hasSkill("perk.legend_battleheart"))
						{
							local difficulty = this.Math.maxf(10.0, 50.0 - this.getXPValue() * 0.1);
							otherActor.checkMorale(-1, difficulty);
						}
						otherActor.m.MaxEnemiesThisTurn = numEnemies;
					}
				}
			}
		}
		else if (this.m.CurrentMovementType == this.Const.Tactical.MovementType.Involuntary)
		{
			if (this.m.MaxEnemiesThisTurn < numOfEnemiesAdjacentToMe)
			{
				if (!this.getSkills().hasSkill("perk.legend_battleheart"))
				{
					local difficulty = 40.0;
					this.checkMorale(-1, difficulty);
				}
			}
		}

		this.m.CurrentMovementType = this.Const.Tactical.MovementType.Default;
		this.m.MaxEnemiesThisTurn = this.Math.max(1, numOfEnemiesAdjacentToMe);

		if (this.isPlayerControlled() && this.getMoraleState() > this.Const.MoraleState.Breaking && this.getMoraleState() != this.Const.MoraleState.Ignore && (_tile.SquareCoords.X == 0 || _tile.SquareCoords.Y == 0 || _tile.SquareCoords.X == 31 || _tile.SquareCoords.Y == 31))
		{
			local change = this.getMoraleState() - this.Const.MoraleState.Breaking;
			this.checkMorale(-change, -1000);
		}

		if (this.m.IsEmittingMovementSounds && this.Const.Tactical.TerrainMovementSound[_tile.Subtype].len() != 0)
		{
			local sound = this.Const.Tactical.TerrainMovementSound[_tile.Subtype][this.Math.rand(0, this.Const.Tactical.TerrainMovementSound[_tile.Subtype].len() - 1)];
			this.Sound.play("sounds/" + sound.File, sound.Volume * this.Const.Sound.Volume.TacticalMovement * this.Math.rand(90, 100) * 0.01, this.getPos(), sound.Pitch * this.Math.rand(95, 105) * 0.01);
		}

		this.spawnTerrainDropdownEffect(_tile);

		if (_tile.Properties.Effect != null && _tile.Properties.Effect.IsAppliedOnEnter)
			_tile.Properties.Effect.Callback(_tile, this);

		this.m.Skills.update();
		this.m.Items.onMovementFinished();
		this.setDirty(true);
		this.m.IsMoving = false;
	}


	q.onMovementInZoneOfControl = @(__original) function( _entity, _isOnEnter )
	{		
		 local reachadvantage = this.m.Skills.getSkillByID("perk.crReachadvantage");
        local spearwall = false;
        if (reachadvantage != null && reachadvantage.m.Opponents.find(_entity.getID()) != null)
            spearwall = true;  // If true, attack when entering ZOC

        if (_isOnEnter && !spearwall && (!this.getCurrentProperties().IsAttackingOnZoneOfControlEnter || !this.getCurrentProperties().IsAttackingOnZoneOfControlAlways && this.getTile().getZoneOfControlCountOtherThan(this.getAlliedFactions()) > 1))
            return false;

        __original( _entity, _isOnEnter );
	}

    q.onAttackOfOpportunity = @(__original) function( _entity, _isOnEnter )
    {
        local reachadvantage = this.m.Skills.getSkillByID("perk.crReachadvantage");
        local spearwall = false;
        if (reachadvantage != null && reachadvantage.m.Opponents.find(_entity.getID()) != null)
            spearwall = true;  // If true, attack when entering ZOC

        if (_isOnEnter && !spearwall && (!this.getCurrentProperties().IsAttackingOnZoneOfControlEnter || !this.getCurrentProperties().IsAttackingOnZoneOfControlAlways && this.getTile().getZoneOfControlCountOtherThan(this.getAlliedFactions()) > 1))
            return false;

        __original( _entity, _isOnEnter );
    }

	q.resetPerks = @(__original) function()
	{
		__original();
		// Remove all flags related to Favoured Enemy Perks
		local flags = this.getFlags();
		local flagsRemoved = 0; 

		foreach (flag in flags.m)
		{
			if (flag.Key.find("favoured_enemy") != null)
			{
				::Mod_Sellswords.Mod.Debug.printLog("Removing flag \"" + flag.Key + "\" for " + this.getName());
				flags.remove(flag.Key);
				flagsRemoved++;
			}
		}

		// Remove perks points that were earned from fulfilling favoured enemy refund requirement
		this.m.PerkPoints -= flagsRemoved;
	};

});
