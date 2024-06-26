::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/shoot_bolt", function ( q ) {

	q.onUse = @(__original) function( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.getItem().setLoaded(false);
		local skillToAdd = this.new("scripts/skills/actives/reload_bolt");
		skillToAdd.setItem(this.getItem());
		skillToAdd.setFatigueCost(this.Math.max(0, skillToAdd.getFatigueCostRaw() + this.getItem().m.FatigueOnSkillUse));
		this.getContainer().add(skillToAdd);
		this.attackEntity(_user, target);

		local ammo = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);
		if (ammo.m.Name == "Quiver of Phantom Bolts")
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
					this.m.Name ="Shoot Bolt";
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
					this.m.Name ="Shoot Bolt";
					this.m.ProjectileType = this.Const.ProjectileType.Arrow;
				}
				this.getContainer().setBusy(false);
			}.bindenv(this), this);
		}

		return true;
	}

	q.onTargetHit <- function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local ammo = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);
		local actor = this.getContainer().getActor();
		local weapon = actor.getMainhandItem()

		if (weapon == null || weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow))
			return;

		if (!actor.isAlive() || actor.isDying())
			return;

		if (!_targetEntity.isAlive() || _targetEntity.isDying())
			return;
		
		if (ammo.m.Name == "Quiver of Serrated Bolts")
		{
			if (!_targetEntity.getCurrentProperties().IsImmuneToBleeding)
			{
				local effect = this.new("scripts/skills/effects/bleeding_effect");
				effect.setDamage(10);
				if (_user.getFaction() == this.Const.Faction.Player )
				{
					effect.setActor(this.getContainer().getActor());
				}
				_targetEntity.getSkills().add(this.new(effect));

				if (!_targetEntity.isHiddenToPlayer())
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is bleeding");
			}
		}

		if (ammo.m.Name == "Quiver of Poisoned Bolts")
		{
			if (_targetEntity.getFlags().has("undead"))
				return;

			if (_targetEntity.getCurrentProperties().IsImmuneToPoison || _targetEntity.getHitpoints() <= 0)
				return;

			if (!_targetEntity.isHiddenToPlayer())
			{
				local poisonSound = [
					"sounds/combat/poison_applied_01.wav",
					"sounds/combat/poison_applied_02.wav"
				];
				this.Sound.play(poisonSound[this.Math.rand(0, poisonSound.len() - 1)], this.Const.Sound.Volume.Actor, _targetEntity.getPos());
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is poisoned");
			}

			local gobboPoison = _targetEntity.getSkills().getSkillByID("effects.goblin_poison");
			if (gobboPoison == null)
				_targetEntity.getSkills().add(this.new("scripts/skills/effects/goblin_poison_effect"));
			else
				gobboPoison.resetTime();
		}

		if (ammo.m.Name == "Quiver of Freezing Bolts")
		{
			if (_targetEntity.getType() == this.Const.EntityType.TricksterGod)
				return;

			if (!_targetEntity.isHiddenToPlayer())
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is chilled");

			local chilled = _targetEntity.getSkills().getSkillByID("effects.chilled");

			if (chilled == null)
				_targetEntity.getSkills().add(this.new("scripts/skills/effects/chilled_effect"));
			else
				chilled.resetTime();
		}
	}

});