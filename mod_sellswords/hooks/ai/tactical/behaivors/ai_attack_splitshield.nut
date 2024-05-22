::mods_hookExactClass("ai/tactical/behaviors/ai_attack_splitshield", function(o) {
	o.onEvaluate = function( _entity )
	{
		this.m.TargetTile = null;
		this.m.Skill = null;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasVisibleOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getActionPoints() < _entity.getActionPointsMax() - 2)
		{
			score = score * this.Const.AI.Behavior.SplitShieldNotFirstActionMult;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		score = score * this.getFatigueScoreMult(this.m.Skill);
		local targets = this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange(), this.m.Skill.getMaxLevelDifference());

		if (targets.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local shieldDamage = _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage() * 1.0;

		if (_entity.getCurrentProperties().IsSpecializedInAxes && this.m.Skill.isAxeMasteryApplied())
		{
			shieldDamage = shieldDamage + this.Math.max(1, shieldDamage / 2) * 1.0;
		}
		
		// this is new
		if (_entity.getSkills().hasSkill("perk.legend_smashing_shields"))
		{
			shieldDamage = (shieldDamage * 1.15).tointeger();
		}
		/////////////////////////////////////////
		
		local myTile = _entity.getTile();
		local bestTarget;
		local bestScore = -9000.0;

		foreach( t in targets )
		{
			if (!t.isArmedWithShield() || !this.m.Skill.isUsableOn(t.getTile()))
			{
				continue;
			}

			local possibleScore = 1.0;
			local possibleShieldDamage = shieldDamage;
			local targetValue = this.queryTargetValue(_entity, t, null);
			possibleScore = possibleScore * targetValue;
			local meleeDefense = t.getCurrentProperties().getMeleeDefense() * this.Const.AI.Behavior.SplitShieldDefenseMult * 0.01;
			possibleScore = possibleScore + meleeDefense;
			possibleScore = possibleScore * (t.getHitpoints() / t.getHitpointsMax());

			if (t.getSkills().hasSkill("perk.shield_expert"))
			{
				shieldDamage = shieldDamage - this.Math.max(1, shieldDamage / 2) * 1.0;
			}
			
			local shieldCondition = t.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).getCondition() * 1.0;

			if (shieldCondition > 500)
			{
				continue;
			}
			
			local item = t.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
			if (item != null && (item.getID() == "shield.legend_parrying_dagger" || item.getID() == "shield.legend_named_parrying_dagger"))
			{
				continue;				
			}
			else if (item != null && item.m.IsIndestructible)
			{
				continue;
			}
			
			local destroyShieldValue = this.Math.maxf(1.0, shieldDamage) * this.Const.AI.Behavior.SplitShieldDamageValueMult / shieldCondition;
			possibleScore = possibleScore * this.Math.pow(this.Math.minf(1.0, destroyShieldValue), 2);

			if (shieldDamage >= shieldDamage)
			{
				possibleScore = possibleScore * this.Const.AI.Behavior.SplitShieldDestroyBonusMult;
			}

			possibleScore = possibleScore * (1.0 - (targets.len() - 1) / 6.0);
			local ZoC = t.getTile().getZoneOfControlCountOtherThan(t.getAlliedFactions());

			if (ZoC > 1)
			{
				possibleScore = possibleScore * this.Math.pow(this.Const.AI.Behavior.SplitShieldAlliesAlsoEngagedMult, ZoC - 1);
			}

			foreach( other in targets )
			{
				if (!other.isArmedWithShield() && this.queryTargetValue(_entity, other, null) >= targetValue * this.Const.AI.Behavior.SplitShieldAlternativeTargetValuePct)
				{
					possibleScore = possibleScore * this.Const.AI.Behavior.SplitShieldAlternativeTargetMult;
				}
			}

			if (possibleScore > bestScore)
			{
				bestTarget = t;
				bestScore = possibleScore;
			}
		}

		if (bestTarget == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = bestTarget.getTile();
		return this.Const.AI.Behavior.Score.SplitShield * score * bestScore;
	}
})