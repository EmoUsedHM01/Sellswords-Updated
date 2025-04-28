::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/throw_spear_skill", function( q ) {
	o.onUse = @(__original) function ( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();
		this.consumeAmmo();
		local shield = targetEntity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (shield != null && shield.isItemType(this.Const.Items.ItemType.Shield))
		{
			local damage = _user.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage();

			if (shield.getID() == "weapon.legend_parrying_dagger" || shield.getID() == "shield.legend_named_parrying_dagger")
			{
				damage *= 0.20;
			}
			if (targetEntity.getCurrentProperties().IsSpecializedInShields && _user.getCurrentProperties().IsSpecializedInThrowing && targetEntity.isArmedWithShield())
			{
				damage *= 2.00;
			}
			local flip = !this.m.IsProjectileRotated && targetEntity.getPos().X > _user.getPos().X;
			local time = this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetTile, 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, time, this.onApplyShieldDamage.bindenv(this), {
				User = _user,
				Skill = this,
				TargetTile = _targetTile,
				Shield = shield,
				Damage = damage
			});
		}
		else
		{
			local ret = this.attackEntity(_user, targetEntity);
		}
		return true;
	}

	q.onAfterUpdate = @(__original) function ( _properties )
	{
		__original(_properties);
		local weapon = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (this.getContainer().hasPerk(::Legends.Perk.LegendSmashingShields);
			weapon.m.ShieldDamage *= 2;
	}
});
