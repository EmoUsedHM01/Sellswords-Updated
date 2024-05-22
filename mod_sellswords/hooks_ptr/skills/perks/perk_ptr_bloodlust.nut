::mods_hookExactClass("skills/perks/perk_ptr_bloodlust", function ( o )
{
	o.onAnySkillExecuted = function ( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (!_skill.isAttack() || _skill.isRanged() || _targetEntity == null)
		{
			return;
		}

		local actor = this.getContainer().getActor();

		if (this.Tactical.TurnSequenceBar.getActiveEntity() == null || this.Tactical.TurnSequenceBar.getActiveEntity().getID() != actor.getID())
		{
			return;
		}

		if (_targetEntity.getID() == actor.getID() || _targetEntity.isAlliedWith(actor))
		{
			return;
		}

		local bleedCount = 0;

		if (!_targetEntity.isAlive() || _targetEntity.isDying())
		{
			bleedCount = this.m.BleedStacksBeforeAttack + 1;			
		}
		else
		{
			bleedCount = _targetEntity.getSkills().getAllSkillsByID("effects.bleeding").len();			
		}

		this.m.FatigueRecoveryStacks += bleedCount;

		local modifiedbleedCount = bleedCount > 3 ? 6 + 3 * bleedCount : 1 + 5 * bleedCount;
		actor.setFatigue(this.Math.max(0, actor.getFatigue() - actor.getFatigue() * (modifiedbleedCount * 0.01)));
	}
});	