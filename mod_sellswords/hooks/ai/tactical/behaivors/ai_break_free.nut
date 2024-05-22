::mods_hookExactClass("ai/tactical/behaviors/ai_break_free", function(o) {
	o.onEvaluate = function( _entity )
	{
		this.m.Skill = null;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.isPlayerControlled() && _entity.getMoraleState() != this.Const.MoraleState.Fleeing && !this.Tactical.State.isAutoRetreat())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!_entity.getCurrentProperties().IsRooted)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}
		
		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}		
		
		local attackSkill = _entity.getSkills().getAttackOfOpportunity();
		local apRequiredForAttack = attackSkill != null ? attackSkill.getActionPointCost() : 4;
		local apBreakfreebeforeattack = apRequiredForAttack + 4;
		
		//usually break free from web before i can attack is a wise choice
		if (_entity.getSkills().hasSkill("effects.web"))
		{
			score * 2;
		}		
		if (_entity.getSkills().hasSkill("effects.web") && this.m.Skill.getChance() >= 50 && _entity.getActionPoints() >= apBreakfreebeforeattack)
		{
			score * 1.5;
		}		
		
		//----------offensive enemies-----------	
		//better break free early when surrounded by lots of polearm guys
		local nextTurnInitiative = _entity.getTurnOrderInitiative();	   	
		local potentialattackers = this.queryTargetsInMeleeRange(1, 2);
		if (potentialattackers.len() != 0)
		{
			foreach( t in potentialattackers )
			{
				if (t.getMoraleState() == this.Const.MoraleState.Fleeing || t.getCurrentProperties().IsStunned)
				{
					continue;
				}

				local polmult = 0;

				if (this.isRangedUnit(t))
				{
					polmult = 0;
				}
				else if (t.isArmedWithMeleeWeapon() && t.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax() == 1)
				{
					polmult = 0.2;
				}
				else if (t.isArmedWithMeleeWeapon() && t.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax() > 1)
				{
					polmult = 0.15;
				}
				score += polmult;				
				if (nextTurnInitiative <= t.getTurnOrderInitiative() && nextTurnInitiative * 2 > t.getTurnOrderInitiative())    //break free will allow me act faster
				{
					score += 0.2;	
				}
				if (!this.Tactical.TurnSequenceBar.isOpponentStillToAct(t) && (t.getSkills().hasSkill("effects.indomitable") || t.getSkills().hasSkill("effects.shieldwall") || t.getSkills().hasSkill("effects.riposte") || t.getSkills().hasSkill("effects.spearwall")))		//if engaged enemies are not aggressive, i will usually attempt to break free
				{
					score += 0.4;	
				}				
			}			
		}
		//this.logInfo("score: " + score);
			
		score = score * this.getFatigueScoreMult(this.m.Skill);

		if (this.m.Skill.getChance() <= 30 && _entity.getTile().hasZoneOfControlOtherThan(_entity.getAlliedFactions()))
		{
			score * 0.25;
		}
		
		if (this.m.Skill.getChance() >= 75)
		{
			score * 3;
		}		

		return this.Const.AI.Behavior.Score.BreakFree * score;
	}
})