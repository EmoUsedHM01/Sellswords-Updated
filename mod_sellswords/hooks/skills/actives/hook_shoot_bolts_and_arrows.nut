foreach (shoot_skill in [
	"shoot_bolt",
	"shoot_stake",
	"quick_shot"
])
{
	::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/" + shoot_skill, function ( q ) {

		q.onUse = @(__original) function( _user, _targetTile )
		{
			local actor = this.getContainer().getActor()
			local ammo = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);
			local weapon = actor.getMainhandItem()
			if (weapon == null) return;


			if (weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow))
			{
				local target = _targetTile.getEntity();
				this.getItem().setLoaded(false);
				local skillToAdd = this.new("scripts/skills/actives/reload_bolt");
				skillToAdd.setItem(this.getItem());
				skillToAdd.setFatigueCost(this.Math.max(0, skillToAdd.getFatigueCostRaw() + this.getItem().m.FatigueOnSkillUse));
				this.getContainer().add(skillToAdd);
				this.attackEntity(_user, target);
				if (ammo.m.Name == "Quiver of Phantom Bolts")
					phantomEffect(_user, _targetTile, actor, "Shoot Bolt");
					return true;
			}
			else if (weapon.isWeaponType(this.Const.Items.WeaponType.Bow))
			{
				local target = _targetTile.getEntity();
				this.consumeAmmo();
				this.attackEntity(_user, target);
				if (ammo.m.Name == "Quiver of Phantom Arrows")
					phantomEffect(_user, target, actor, "Quick Shot");
					return true;
			}
		}

		q.phantomEffect <- function (_user, _target, _actor, _name)
		{
			local skill = _actor.getSkills().getSkillByID("effects.phantom_strike");
			local stacks = skill.m.PhantomStacks;
			skill.m.skillCount = this.Const.SkillCounter;
			this.m.IsDoingAttackMove = false;
			this.getContainer().setBusy(true);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, function ( _skill )
			{
				if (_target.isAlive())
				{
					this.m.ProjectileType = this.Const.ProjectileType.None;

					local prop = _user.getCurrentProperties();
					prop.DamageTotalMult *= (0.1*(stacks)+ 0.3);
					prop.RangedAttackBlockedChanceMult *= 0;
					this.m.Name = "Phantom Strike";
					this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
					this.attackEntity(_user, _target);
					this.m.Name = _name;
					this.m.ProjectileType = this.Const.ProjectileType.Arrow;
				}
			}.bindenv(this), this);

			this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, function ( _skill )
			{
				if (_target.isAlive())
				{
					this.m.ProjectileType = this.Const.ProjectileType.None;

					local prop = _user.getCurrentProperties();
					prop.DamageTotalMult *= (0.1*(stacks)+ 0.3);
					prop.RangedAttackBlockedChanceMult *= 0;
					this.m.Name = "Phantom Strike";
					this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
					this.attackEntity(_user, _target);
					this.m.Name = _name;
					this.m.ProjectileType = this.Const.ProjectileType.Arrow;
				}
				this.getContainer().setBusy(false);
			}.bindenv(this), this);
		}
		if (!shoot_skill == "shoot_stake")
		{
			q.onTargetHit <- function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
			{
				local actor = this.getContainer().getActor();
				local ammo = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);
				local weapon = actor.getMainhandItem()

				if (weapon == null)
					return;

				if (!actor.isAlive() || actor.isDying())
					return;

				if (!_targetEntity.isAlive() || _targetEntity.isDying())
					return;

				if (weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow))
					if (ammo.m.Name == "Quiver of Serrated Bolts")
						return bleedingEffect(actor, _targetEntity);
					if (ammo.m.Name == "Quiver of Poisoned Bolts")
						return poisonEffect(_targetEntity);
					if (ammo.m.Name == "Quiver of Freezing Bolts")
						return freezingEffect(_targetEntity);

				if (weapon.isWeaponType(this.Const.Items.WeaponType.Bow))
					if (ammo.m.Name == "Quiver of Serrated Arrows")
						return bleedingEffect(actor, _targetEntity);
					if (ammo.m.Name == "Quiver of Poisoned Arrows")
						return poisonEffect(_targetEntity);
					if (ammo.m.Name == "Quiver of Freezing Arrows")
						return freezingEffect(_targetEntity);
			}
		}
		else
		{
			q.onTargetHit = @(__original) function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
			{
				local actor = this.getContainer().getActor();
				local ammo = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);
				local weapon = actor.getMainhandItem()

				if (weapon == null || _skill != this)
					return;

				if (!actor.isAlive() || actor.isDying())
					return;

				if (!_targetEntity.isAlive() || _targetEntity.isDying())
					return;

				if (weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow))
					if (weapon.getID() == "weapon.goblin_crossbow")
						knockbackEffect();
					if (ammo.m.Name == "Quiver of Serrated Bolts")
						return bleedingEffect(actor, _targetEntity);
					if (ammo.m.Name == "Quiver of Poisoned Bolts")
						return poisonEffect(_targetEntity);
					if (ammo.m.Name == "Quiver of Freezing Bolts")
						return freezingEffect(_targetEntity);


				if (weapon.isWeaponType(this.Const.Items.WeaponType.Bow))
					if (ammo.m.Name == "Quiver of Serrated Arrows")
						return bleedingEffect(actor, _targetEntity);
					if (ammo.m.Name == "Quiver of Poisoned Arrows")
						return poisonEffect(_targetEntity);
					if (ammo.m.Name == "Quiver of Freezing Arrows")
						return freezingEffect(_targetEntity);
			}
		}

		q.knockbackEffect <- function(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor)
		{
			if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
			{
				local targetTile = _targetEntity.getTile();
				local user = this.getContainer().getActor();

				if (_targetEntity.getCurrentProperties().IsImmuneToKnockBackAndGrab || _targetEntity.getCurrentProperties().IsRooted)
				{
					return false;
				}

				local knockToTile = this.findTileToKnockBackTo(user.getTile(), targetTile);

				if (knockToTile == null)
				{
					return;
				}

				if (!user.isHiddenToPlayer() && (targetTile.IsVisibleForPlayer || knockToTile.IsVisibleForPlayer))
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " has knocked back " + this.Const.UI.getColorizedEntityName(_targetEntity));
				}

				local skills = _targetEntity.getSkills();
				skills.removeByID("effects.shieldwall");
				skills.removeByID("effects.spearwall");
				skills.removeByID("effects.riposte");
				local damage = this.Math.max(0, this.Math.abs(knockToTile.Level - targetTile.Level) - 1) * this.Const.Combat.FallingDamage;

				if (damage == 0)
				{
					this.Tactical.getNavigator().teleport(_targetEntity, knockToTile, null, null, true);
				}
				else
				{
					local p = this.getContainer().getActor().getCurrentProperties();
					local tag = {
						Attacker = user,
						Skill = this,
						HitInfo = clone this.Const.Tactical.HitInfo,
						HitInfoBash = null
					};
					tag.HitInfo.DamageRegular = damage;
					tag.HitInfo.DamageFatigue = this.Const.Combat.FatigueReceivedPerHit;
					tag.HitInfo.DamageDirect = 1.0;
					tag.HitInfo.BodyPart = this.Const.BodyPart.Body;
					tag.HitInfo.BodyDamageMult = 1.0;
					tag.HitInfo.FatalityChanceMult = 1.0;
					this.Tactical.getNavigator().teleport(_targetEntity, knockToTile, this.onKnockedDown, tag, true);
				}
			}
		}

		q.bleedingEffect <- function(_actor, _targetEntity)
		{
			if (!_targetEntity.getCurrentProperties().IsImmuneToBleeding)
			{
				local effect = this.new("scripts/skills/effects/bleeding_effect");
				effect.setDamage(10);
				if (_actor.getFaction() == this.Const.Faction.Player )
				{
					effect.setActor(this.getContainer().getActor());
				}
				_targetEntity.getSkills().add(this.new(effect));

				if (!_targetEntity.isHiddenToPlayer())
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is bleeding");
			}
		}

		q.poisonEffect <- function(_targetEntity)
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

		q.freezingEffect <- function(_targetEntity)
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
	});
}
