::mods_hookExactClass("skills/perks/perk_ptr_sanguinary", function ( o )
{
	o.onAnySkillExecuted = function ( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_targetEntity != null && this.m.DidHit && (this.m.WasBleeding || (_targetEntity.isAlive() && !_targetEntity.isDying() && _targetEntity.getSkills().hasSkill("effects.bleeding"))))
		{
			local actor = this.getContainer().getActor();
			if (actor.getMoraleState() < this.Const.MoraleState.Confident && actor.getMoraleState() != this.Const.MoraleState.Fleeing)
			{
				actor.setMoraleState(actor.getMoraleState() + 1);
				this.spawnIcon("perk_ptr_sanguinary", actor.getTile());
			}
		}
		this.m.DidHit = false;
		this.m.WasBleeding = false;
	}
});	