::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/actor", function ( q ) {

	q.onInit = @(__original) function()
	{
		__original();
		this.getSkills().add(this.new("scripts/skills/effects/ssu_bolstered_effect"));
		this.getSkills().add(this.new("scripts/skills/effects/ssu_armor_fatigue_recovery_effect"));
	}

	q.onOtherActorDeath = @(__original) function ( _killer, _victim, _skill )
	{
		if (!this.m.IsAlive || this.m.IsDying)
			return;

		if (_victim.getXPValue() <= 1)
			return;

		if (_victim.getType() == this.Const.EntityType.Wardog || _victim.getType() == this.Const.EntityType.Warhound)
			return;

		if (_victim.getFaction() == this.getFaction() && _victim.getCurrentProperties().TargetAttractionMult > 0.5 && this.getCurrentProperties().IsAffectedByDyingAllies)
		{
			local difficulty = this.Const.Morale.AllyKilledBaseDifficulty - _victim.getXPValue() * this.Const.Morale.AllyKilledXPMult + this.Math.pow(_victim.getTile().getDistanceTo(this.getTile()), this.Const.Morale.AllyKilledDistancePow);
			if (_killer != null)
			{
				difficulty = this.Math.floor((this.Const.Morale.AllyKilledBaseDifficulty - _victim.getXPValue() * this.Const.Morale.AllyKilledXPMult + this.Math.pow(_victim.getTile().getDistanceTo(this.getTile()), this.Const.Morale.AllyKilledDistancePow)) * _killer.getPercentOnKillOtherActorModifier()) + _killer.getFlatOnKillOtherActorModifier();
			}

			this.checkMorale(-1, difficulty, this.Const.MoraleCheckType.Default, "", true);
		}
		else if (this.getAlliedFactions().find(_victim.getFaction()) == null)
		{
			local difficulty = this.Const.Morale.EnemyKilledBaseDifficulty + _victim.getXPValue() * this.Const.Morale.EnemyKilledXPMult - this.Math.pow(_victim.getTile().getDistanceTo(this.getTile()), this.Const.Morale.EnemyKilledDistancePow);
			if (_killer != null && _killer.isAlive() && _killer.getID() == this.getID())
				difficulty = difficulty + this.Const.Morale.EnemyKilledSelfBonus;

			this.checkMorale(1, difficulty);
		}
	}

	q.onMovementFinish = @(__original) function (_tile) 
	{
		this.m.IsMoving = true;
		this.updateVisibility(_tile, this.m.CurrentProperties.getVision(), this.getFaction());

		if (this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() != this.getID())
			this.Tactical.TurnSequenceBar.getActiveEntity().updateVisibilityForFaction();

		this.setZoneOfControl(_tile, this.hasZoneOfControl());

		if (!this.m.IsExertingZoneOfOccupation) 
		{
			_tile.addZoneOfOccupation(this.getFaction());
			this.m.IsExertingZoneOfOccupation = true;
		}

		if (this.Const.Tactical.TerrainEffect[_tile.Type].len() > 0 && !this.m.Skills.hasSkill(this.Const.Tactical.TerrainEffectID[_tile.Type]))
			this.m.Skills.add(this.new(this.Const.Tactical.TerrainEffect[_tile.Type]));

		if (_tile.IsHidingEntity)
			this.m.Skills.add(this.new(this.Const.Movement.HiddenStatusEffect));

		local numOfEnemiesAdjacentToMe = _tile.getZoneOfControlCountOtherThan(this.getAlliedFactions());

		if (this.m.CurrentMovementType == this.Const.Tactical.MovementType.Default)
		{
			if (this.m.MoraleState != this.Const.MoraleState.Fleeing)
			{
				for (local i = 0; i != 6; i = ++i)
				{
					if (!_tile.hasNextTile(i))
						continue;

					local otherTile = _tile.getNextTile(i);

					if (!otherTile.IsOccupiedByActor)
						continue;

					local otherActor = otherTile.getEntity();
					local numEnemies = otherTile.getZoneOfControlCountOtherThan(otherActor.getAlliedFactions());

					// Check if the actor has the battleheart perk
					if (otherActor.m.MaxEnemiesThisTurn < numEnemies && !otherActor.isAlliedWith(this))
					{
						if (!otherActor.getSkills().hasSkill("perk.legend_battleheart"))
						{
							local difficulty = this.Math.maxf(10.0, 50.0 - this.getXPValue() * 0.1);
							otherActor.checkMorale(-1, difficulty);
						}
						otherActor.m.MaxEnemiesThisTurn = numEnemies;
					}
				}
			}
		}
		else if (this.m.CurrentMovementType == this.Const.Tactical.MovementType.Involuntary)
		{
			if (this.m.MaxEnemiesThisTurn < numOfEnemiesAdjacentToMe)
			{
				if (!this.getSkills().hasSkill("perk.legend_battleheart"))
				{
					local difficulty = 40.0;
					this.checkMorale(-1, difficulty);
				}
			}
		}

		this.m.CurrentMovementType = this.Const.Tactical.MovementType.Default;
		this.m.MaxEnemiesThisTurn = this.Math.max(1, numOfEnemiesAdjacentToMe);

		if (this.isPlayerControlled() && this.getMoraleState() > this.Const.MoraleState.Breaking && this.getMoraleState() != this.Const.MoraleState.Ignore && (_tile.SquareCoords.X == 0 || _tile.SquareCoords.Y == 0 || _tile.SquareCoords.X == 31 || _tile.SquareCoords.Y == 31))
		{
			local change = this.getMoraleState() - this.Const.MoraleState.Breaking;
			this.checkMorale(-change, -1000);
		}

		if (this.m.IsEmittingMovementSounds && this.Const.Tactical.TerrainMovementSound[_tile.Subtype].len() != 0)
		{
			local sound = this.Const.Tactical.TerrainMovementSound[_tile.Subtype][this.Math.rand(0, this.Const.Tactical.TerrainMovementSound[_tile.Subtype].len() - 1)];
			this.Sound.play("sounds/" + sound.File, sound.Volume * this.Const.Sound.Volume.TacticalMovement * this.Math.rand(90, 100) * 0.01, this.getPos(), sound.Pitch * this.Math.rand(95, 105) * 0.01);
		}

		this.spawnTerrainDropdownEffect(_tile);

		if (_tile.Properties.Effect != null && _tile.Properties.Effect.IsAppliedOnEnter)
			_tile.Properties.Effect.Callback(_tile, this);

		this.m.Skills.update();
		this.m.Items.onMovementFinished();
		this.setDirty(true);
		this.m.IsMoving = false;
	}


	q.onMovementInZoneOfControl = @(__original) function( _entity, _isOnEnter )
	{		
		if (!this.m.IsActingEachTurn)
			return false;

		if (!this.m.IsUsingZoneOfControl || !this.m.IsExertingZoneOfControl)
			return false;

		if (this.m.MoraleState == this.Const.MoraleState.Fleeing || this.getCurrentProperties().IsStunned)
			return false;

		local reachadvantage = this.m.Skills.getSkillByID("perk.ssu_reachadvantage");
		local spearwall = false;	
		if (reachadvantage != null && reachadvantage.m.Opponents.find(_entity.getID()) != null)
			spearwall = true;  //if true, attack when entering ZOC

		if (_isOnEnter && !spearwall && (!this.getCurrentProperties().IsAttackingOnZoneOfControlEnter || !this.getCurrentProperties().IsAttackingOnZoneOfControlAlways && this.getTile().getZoneOfControlCountOtherThan(this.getAlliedFactions()) > 1))
			return false;

		if (!_entity.getCurrentProperties().IsImmuneToZoneOfControl && !_entity.isAlliedWith(this))
		{
			local skill = this.m.Skills.getAttackOfOpportunity();

			if (skill != null)
				return true;
		}

		return false;
	}

	q.onAttackOfOpportunity = @(__original) function( _entity, _isOnEnter )
	{	
		if (!this.m.IsActingEachTurn)
			return false;

		if (!this.m.IsUsingZoneOfControl || !this.m.IsExertingZoneOfControl)
			return false;

		if (this.m.MoraleState == this.Const.MoraleState.Fleeing || this.getCurrentProperties().IsStunned)
			return false;

		local reachadvantage = this.m.Skills.getSkillByID("perk.ssu_reachadvantage");
		local spearwall = false;
		if (reachadvantage != null && reachadvantage.m.Opponents.find(_entity.getID()) != null)
			spearwall = true;  //if true, attack when entering ZOC

		if (_isOnEnter && !spearwall && (!this.getCurrentProperties().IsAttackingOnZoneOfControlEnter || !this.getCurrentProperties().IsAttackingOnZoneOfControlAlways && this.getTile().getZoneOfControlCountOtherThan(this.getAlliedFactions()) > 1))
			return false;

		if (_entity.getTile().Properties.Effect != null && _entity.getTile().Properties.Effect.Type == "smoke")
			return false;

		if (!_entity.getCurrentProperties().IsImmuneToZoneOfControl && !_entity.isAlliedWith(this))
		{
			local skill = this.m.Skills.getAttackOfOpportunity();

			if (skill != null)
			{
				if (skill.useForFree(_entity.getTile()))
				{
					_entity.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
					return true;
				}
			}
		}

		return false;
	}

	q.resetPerks = @(__original) function()
	{
		__original();
		// Remove all flags related to Favoured Enemy Perks
		local flags = this.getFlags();
		local flagsRemoved = 0; 

		foreach (flag in flags.m)
		{
			if (flag.Key.find("favoured_enemy") != null)
			{
				::Mod_Sellswords.Mod.Debug.printLog("Removing flag \"" + flag.Key + "\" for " + this.getName());
				flags.remove(flag.Key);
				flagsRemoved++;
			}
		}

		// Remove perks points that were earned from fulfilling favoured enemy refund requirement
		this.m.PerkPoints -= flagsRemoved;
	};

	// Legends crosses the two weapons of a dual wielder, here they are held out side by side and tilted down
	// the numbers are in mod_sellswords\config\ssu_dual_wield.nut
	q.m.SsuDualWieldTilt <- 0; // the tilt that is on the main hand weapon right now
	q.m.SsuDualWieldBase <- 0; // the rotation vanilla gave the main hand weapon, 0 or the angle of a lowered weapon
	q.m.IsSsuDualWieldPosed <- false; // true while the weapons are in one of the two poses
	q.m.IsSsuDualWieldInBattle <- false; // true from being placed on the battle map until the battle is over

	// both of these write the whole rotation and never add to what the sprite has, so the tilt can not stack up
	q.addSsuDualWieldTilt <- function( _tilt )
	{
		this.getSprite("arms_icon").Rotation = this.m.SsuDualWieldBase - _tilt;
		this.m.SsuDualWieldTilt = _tilt;
	}

	// vanilla starts its raise weapon animation when the rotation is not exactly 0, so its own value is put back
	q.removeSsuDualWieldTilt <- function()
	{
		if (this.m.SsuDualWieldTilt == 0)
			return;

		this.getSprite("arms_icon").Rotation = this.m.SsuDualWieldBase;
		this.m.SsuDualWieldTilt = 0;
	}

	q.flipOffhandSprite = @(__original) function()
	{
		__original();

		local pose = ::Mod_Sellswords.DualWield;
		local flip = !this.isAlliedWithPlayer();
		local facing = flip ? -1 : 1;
		local offhand = this.getSprite("shield_icon");

		offhand.setHorizontalFlipping(flip);
		this.m.IsSsuDualWieldPosed = true;

		// outside of battles only the portrait is seen, and a portrait shows where a sprite was moved to but not its tilt
		// so there the off hand weapon just sits a little behind and below the main hand one
		if (!this.m.IsSsuDualWieldInBattle || !this.isPlacedOnMap())
		{
			this.removeSsuDualWieldTilt();
			offhand.Rotation = 0;
			this.setSpriteOffset("shield_icon", this.createVec(-facing * pose.PortraitDistance, -pose.PortraitDown));
			this.setSpriteOffset("arms_icon", this.createVec(0, 0));
			return;
		}

		offhand.Rotation = -pose.Tilt;
		this.setSpriteOffset("shield_icon", this.createVec(facing * (pose.Forward - pose.Distance), -pose.Down));
		this.setSpriteOffset("arms_icon", this.createVec(facing * pose.Forward, -pose.Down));

		this.addSsuDualWieldTilt(pose.Tilt);
	}

	q.onAppearanceChanged = @(__original) function( _appearance, _setDirty = true )
	{
		local wasPosed = this.m.IsSsuDualWieldPosed;

		// vanilla reads the rotation of the weapon and the height of the shield to start its own animations
		// so the pose comes off while it looks, Legends puts it back on if the unit is still dual wielding
		if (wasPosed)
		{
			this.removeSsuDualWieldTilt();
			this.setSpriteOffset("shield_icon", this.createVec(0, 0));
			this.m.IsSsuDualWieldPosed = false;
		}

		__original(_appearance, _setDirty);

		// no longer dual wielding, Legends resets the off hand and the rest is put back here
		if (wasPosed && !this.m.IsSsuDualWieldPosed)
		{
			this.setSpriteOffset("arms_icon", this.createVec(0, 0));
			this.getSprite("shield_icon").Rotation = 0;
		}
	}

	q.onRender = @(__original) function()
	{
		local swinging = this.m.IsLoweringWeapon || this.m.IsRaisingWeapon;
		__original();

		if (!swinging)
			return;

		local rotation = this.getSprite("arms_icon").Rotation;
		local tilted = this.m.SsuDualWieldBase - this.m.SsuDualWieldTilt;

		// still the value from the last frame, so the animation did not write anything new
		if (this.m.SsuDualWieldTilt != 0 && rotation > tilted - 0.01 && rotation < tilted + 0.01)
			return;

		// the vanilla lower and raise weapon animation writes the rotation itself, that is remembered and the tilt goes on top
		this.m.SsuDualWieldBase = rotation > -0.01 && rotation < 0.01 ? 0 : rotation;

		if (this.m.SsuDualWieldTilt != 0)
		{
			this.addSsuDualWieldTilt(this.m.SsuDualWieldTilt);
		}
	}

	q.onPlacedOnMap = @(__original) function()
	{
		__original();

		// a battle has its own clock, so an animation that was started on the world map would never finish here
		this.m.IsRaisingWeapon = false;
		this.m.IsLoweringWeapon = false;
		this.m.IsRaisingShield = false;
		this.m.IsLoweringShield = false;
		this.m.SsuDualWieldBase = 0;

		// the battle pose starts when the unit is put on the battle map
		this.m.IsSsuDualWieldInBattle = true;

		if (this.hasSprite("shield_icon") && ::Legends.Weapons.isDualWielding(this))
		{
			this.flipOffhandSprite();
		}
	}

	// called for the player characters when a battle is over, which puts them back in the portrait pose
	q.resetRenderEffects = @(__original) function()
	{
		__original();
		this.m.SsuDualWieldTilt = 0;
		this.m.SsuDualWieldBase = 0;
		this.m.IsSsuDualWieldPosed = false;
		this.m.IsSsuDualWieldInBattle = false;

		if (!this.hasSprite("shield_icon"))
			return;

		this.getSprite("shield_icon").Rotation = 0;

		if (::Legends.Weapons.isDualWielding(this))
		{
			this.flipOffhandSprite();
		}
	}

});

::Mod_Sellswords.HooksMod.hookTree("scripts/entity/tactical/actor", function ( q ) {

	if (!q.contains("getLootForTile"))
		return;

	q.getLootForTile = @(__original) function ( _killer, _loot )
	{
		return __original(::Mod_Sellswords.AllLootDrops ? null : _killer, _loot);
	}

});
