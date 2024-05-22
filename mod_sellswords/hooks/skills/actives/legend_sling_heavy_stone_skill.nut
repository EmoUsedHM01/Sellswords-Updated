::mods_hookExactClass("skills/actives/legend_sling_heavy_stone_skill", function(o) 
{
	o.onTargetHit = function(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor)
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));
		}

		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying() && !_targetEntity.getCurrentProperties().IsImmuneToStun)
		{
			local targetTile = _targetEntity.getTile();
			local user = this.getContainer().getActor();

			if (_bodyPart == this.Const.BodyPart.Head)
			{
				_targetEntity.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));
				
				if (user.getCurrentProperties().IsSpecializedInStaffStun)
				{
					if (!_targetEntity.getCurrentProperties().IsImmuneToStun)
					{
						_targetEntity.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));
					}
				}
				
				if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " dazed");
				}
			}
		}
	}

})