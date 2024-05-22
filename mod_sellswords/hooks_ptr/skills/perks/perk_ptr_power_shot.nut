::mods_hookExactClass("skills/perks/perk_ptr_power_shot", function ( o )
{
	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_skill.isAttack() || !_skill.isRanged() || !_targetEntity.isAlive() || _targetEntity.isDying() || !this.isEnabled())
		{
			return;
		}
		local roll = this.Math.rand(1, 100);
		if (roll <= this.m.Chance || _bodyPart == this.Const.BodyPart.Head)
		{
			local effect = this.new("scripts/skills/effects/staggered_effect");
			_targetEntity.getSkills().add(effect);
			effect.m.TurnsLeft = 1;

			if (!this.getContainer().getActor().isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " has staggered " + this.Const.UI.getColorizedEntityName(_targetEntity) + " for " + effect.m.TurnsLeft + " turn(s)");
			}
		}
	}
});	