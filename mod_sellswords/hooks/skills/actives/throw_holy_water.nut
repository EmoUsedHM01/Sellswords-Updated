::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/throw_holy_water", function( q ) {
	q.onUse = @( __original ) function( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();

		if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
		{
			local flip = !this.m.IsProjectileRotated && targetEntity.getPos().X > _user.getPos().X;

			if (_user.getTile().getDistanceTo(targetEntity.getTile()) >= this.Const.Combat.SpawnProjectileMinDist)
			{
				this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), targetEntity.getTile(), 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			}
		}

		this.consumeAmmo();

		this.Time.scheduleEvent(this.TimeUnit.Real, 200, this.onApplyEffect.bindenv(this), {
			Skill = this,
			TargetTile = _targetTile
		});
	}

	q.onAfterUpdate = @( __original ) function( _properties )
	{
		__original(_properties);
		this.m.MaxRange = _properties.IsSpecializedInNets ? 5 : 3;
	}

});