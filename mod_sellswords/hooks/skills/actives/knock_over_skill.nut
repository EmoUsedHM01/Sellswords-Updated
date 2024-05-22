::mods_hookExactClass("skills/actives/knock_over_skill", function ( o )
{
	o.onUse = function ( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, _targetTile.getEntity());
		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}
		if (success && _targetTile.IsOccupiedByActor)
		{
			local target = _targetTile.getEntity();

			if ((_user.getCurrentProperties().IsSpecializedInMaces || this.Math.rand(1, 100) <= this.m.StunChance))
			{
				if (!target.getCurrentProperties().IsImmuneToStun && !target.getSkills().hasSkill("effects.stunned"))
				{
					target.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));					
					if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
					{
						this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has stunned " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
					}
				}
				if (_user.getSkills().hasSkill("perk.ptr_push_it"))
				{
					target.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));					
					if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
					{
						this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has staggered " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
					}					
				}
			}
		}
		return success;
	}
});	