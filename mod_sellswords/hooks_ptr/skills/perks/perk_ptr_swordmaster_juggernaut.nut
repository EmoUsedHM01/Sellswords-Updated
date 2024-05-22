::mods_hookExactClass("skills/perks/perk_ptr_swordmaster_juggernaut", function ( o )
{
	o.onBeforeTargetHit = function( _skill, _targetEntity, _hitInfo )
	{
		if (this.m.Target != null || !_skill.isAttack() || _skill.isAOE() || !this.isEnabled())
		{
			this.m.Target = null;
			return;
		}

		this.m.Target = null;

		local targetTile = _targetEntity.getTile();

		local targets = [];

		for (local i = 0; i < 6; i++)
		{
			if (targetTile.hasNextTile(i))
			{
				local nextTile = targetTile.getNextTile(i);
				if (nextTile.IsOccupiedByActor)
				{
					local entity = nextTile.getEntity();
					if (!entity.isAlliedWith(this.getContainer().getActor())) targets.push(entity);
				}
			}
		}

		this.m.Target = ::MSU.Array.rand(targets);
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.m.Target != null && this.m.Target.isAlive())
		{
			_skill.onUse(this.getContainer().getActor(), this.m.Target.getTile());
			this.m.Target = null;
		}
	}
});	