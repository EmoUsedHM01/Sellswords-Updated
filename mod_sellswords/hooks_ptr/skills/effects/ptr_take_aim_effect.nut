::mods_hookExactClass("skills/effects/ptr_take_aim_effect", function(o) {
	
	o.getTooltip = function()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "For ranged attacks in this turn:"
		});

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Crossbows ignore any hitchance penalty from obstacles, and the shot cannot go astray."
		});

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Handgonnes have their Maximum Range increased by 1 and if used at shorter range, have their area of effect increased by 1 instead."
		});
		
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Fire lances will have a 50% chance to disarm enemies when using Ignite."
		});		

		return tooltip;
	}

	o.onTargetHit <- function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_skill.isAttack() || !_skill.isRanged() || !_targetEntity.isAlive() || _targetEntity.isDying())
		{
			return;
		}
		
		if (this.Math.rand(1, 100) <= 50 && _skill.getID() == "actives.ignite_firelance")
		{
			local effect = this.new("scripts/skills/effects/disarmed_effect");
			if (!_targetEntity.getCurrentProperties().IsStunned && !_targetEntity.getCurrentProperties().IsImmuneToDisarm)
			{
				_targetEntity.getSkills().add(effect);

				if (!this.getContainer().getActor().isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " has disarmed " + this.Const.UI.getColorizedEntityName(_targetEntity) + " for " + effect.m.TurnsLeft + " turn(s)");
				}
			}	
		}
	}

	o.onAfterUpdate = function(_properties)
	{
		local skill = this.getContainer().getSkillByID("actives.fire_handgonne");
		if (skill != null)
		{
			skill.m.MaxRange += 1;
			skill.m.FatigueCost += 10;			
		}
		local crskill = this.getContainer().getSkillByID("actives.ignite_firelance");
		if (crskill != null)
		{
			_properties.RangedSkill += 10;
			crskill.m.FatigueCost += 10;				
		}
		local crrskill = this.getContainer().getSkillByID("actives.legend_piercing_bolt");
		if (crrskill != null)
		{
			crrskill.m.FatigueCost += 10;				
		}
		local crrrskill = this.getContainer().getSkillByID("actives.actives.shoot_bolt");
		if (crrrskill != null)
		{
			crrskill.m.FatigueCost += 10;				
		}		
	}

	o.onAnySkillExecuted = function( _skill, _targetTile, _targetEntity, _forFree )
	{
	}
})