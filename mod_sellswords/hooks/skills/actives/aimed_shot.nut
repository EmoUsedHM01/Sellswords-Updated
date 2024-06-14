::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/aimed_shot", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.FatigueCost = 20;
		this.m.ActionPointCost = 6;
	}

	q.onUse = @(__original) function( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.consumeAmmo();
		this.attackEntity(_user, target);

		local ammo = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);
		if (ammo.m.Name == "Quiver of Phantom Arrows")
		{
			local skill = this.getContainer().getActor().getSkills().getSkillByID("effects.phantom_strike");
			local stacks = skill.m.PhantomStacks;
			skill.m.skillCount = this.Const.SkillCounter;
			this.m.IsDoingAttackMove = false;
			this.getContainer().setBusy(true);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, function ( _skill )
			{
				if (target.isAlive())
				{
					this.m.ProjectileType = this.Const.ProjectileType.None;

					local prop = _user.getCurrentProperties();
					prop.DamageTotalMult *= (0.1*(stacks)+ 0.3);
					prop.RangedAttackBlockedChanceMult *= 0;
					this.m.Name ="Phantom Strike";
					this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
					this.attackEntity(_user, target);
					this.m.Name ="Aimed Shot";
					this.m.ProjectileType = this.Const.ProjectileType.Arrow;
				}
			}.bindenv(this), this);

			this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, function ( _skill )
			{
				if (target.isAlive())
				{
					this.m.ProjectileType = this.Const.ProjectileType.None;

					local prop = _user.getCurrentProperties();
					prop.DamageTotalMult *= (0.1*(stacks)+ 0.3);
					prop.RangedAttackBlockedChanceMult *= 0;
					this.m.Name ="Phantom Strike";
					this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
					this.attackEntity(_user, target);
					this.m.Name ="Aimed Shot";
					this.m.ProjectileType = this.Const.ProjectileType.Arrow;
				}
				this.getContainer().setBusy(false);
			}.bindenv(this), this);
		}

		return true;
	}

	q.onAnySkillUsed = @( __original) function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;

			if (this.getContainer().hasSkill("perk.ptr_target_practice"))
				_properties.DamageRegularMult *= 1.15;
			else
				_properties.DamageRegularMult *= 1.1;
		}
	}

});