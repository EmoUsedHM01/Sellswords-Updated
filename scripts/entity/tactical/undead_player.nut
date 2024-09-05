this.undead_player <- this.inherit("scripts/entity/tactical/player", {
	m = {
		PotentialPermanentInjuries = [],
		UndeadType = this.Const.Necro.UndeadType.Zombie,
		InjuryType = 1,
		BodySpriteName = "",
		ResurrectWithScript = "",
		ResurrectionValue = 10.0,
		ChanceToTakeNoInjury = 25,
		CanAutoResurrect = false,
		IsResurrectingOnFatality = false,
		IsHeadless = false,
		WasInjured = false,
		IsReallyDead = false,
	},

	function improveMood( _a = 1.0, _reason = "" )
	{
		if (this.m.UndeadType == this.Const.Necro.UndeadType.Vampire)
			this.player.improveMood(_a, _reason);
		else
		{
			this.m.Mood = 3.0;
			this.getSkills().update();
		}
	}

	function worsenMood( _a = 1.0, _reason = "" )
	{
		if (this.m.UndeadType == this.Const.Necro.UndeadType.Vampire)
			this.player.worsenMood(_a, _reason);
		else
		{
			this.m.Mood = 3.0;
			this.getSkills().update();
		}
	}

	function recoverMood()
	{
		if (this.m.UndeadType == this.Const.Necro.UndeadType.Vampire)
			this.player.recoverMood();
	}

	function create()
	{
		this.player.create();
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.ExcludedInjuries = [
			"injury.cut_artery",
			"injury.cut_throat",
			"injury.deep_abdominal_cut",
			"injury.deep_chest_cut",
			"injury.exposed_ribs",
			"injury.grazed_kidney",
			"injury.grazed_neck",
			"injury.infected_wound",
			"injury.sickness",
			"injury.stabbed_guts",
			"injury.broken_nose",
			"injury.broken_ribs",
			"injury.crushed_windpipe",
			"injury.fractured_ribs",
			"injury.inhaled_flames",
			"injury.pierced_chest",
			"injury.pierced_lung",
			"injury.pierced_side"
		];
		this.m.Flags.add("undead");
		this.m.Flags.remove("human");
	}

	function onCombatFinished()
	{
		this.m.WasInjured = false;
		this.m.IsResurrected = false;
		this.player.onCombatFinished();
	}

	function setHeadLess( _f )
	{
		if (this.m.UndeadType != this.Const.Necro.UndeadType.Zombie)
			return;

		if (_f && this.m.IsHeadless)
			return;

		if (_f)
		{
			this.m.IsHeadless = true;
			//this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = [];
			this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [];
			this.m.Sound[this.Const.Sound.ActorEvent.Death] = [];
			this.m.Sound[this.Const.Sound.ActorEvent.Flee] = [];
			this.m.Sound[this.Const.Sound.ActorEvent.Resurrect] = [];
			this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [];
			this.getSprite("head").setBrush("zombify_no_head");
			this.getSprite("head").Saturation = 1.0;
			this.getSprite("head").Color = this.createColor("#ffffff");
			this.getSprite("injury").Visible = false;
			this.getSprite("hair").Visible = false;
			this.getSprite("beard").Visible = false;
			this.getSprite("beard_top").Visible = false;
			this.getSprite("status_rage").Visible = false;
			this.getSprite("tattoo_head").Visible = false;
			this.getSprite("helmet").Visible = false;
			this.getSprite("helmet_damage").Visible = false;
			this.getSprite("body_blood").Visible = false;
			this.getSprite("dirt").Visible = false;
		}
		else
		{
			this.m.IsHeadless = false;
			this.setZombieAttributes();
			local head = this.getSprite("head");
			head.setBrush(this.Const.Faces.AllHuman[this.Math.rand(0, this.Const.Faces.AllHuman.len() - 1)]);
			head.Saturation = body.Saturation;
			head.Color = body.Color;
			this.getSprite("injury").Visible = true;
			this.getSprite("hair").Visible = true;
			this.getSprite("beard").Visible = true;
			this.getSprite("beard_top").Visible = true;
			this.getSprite("status_rage").Visible = true;
			this.getSprite("tattoo_head").Visible = true;
			this.getSprite("helmet").Visible = true;
			this.getSprite("helmet_damage").Visible = true;
			this.getSprite("body_blood").Visible = true;
			this.getSprite("dirt").Visible = true;
		}
	}

	function onTurnStart()
	{
		this.player.onTurnStart();
		this.playIdleSound();
	}

	function onTurnResumed()
	{
		this.player.onTurnResumed();
		this.playIdleSound();
	}

	function playSound( _type, _volume, _pitch = 1.0 )
	{
		if (_type == this.Const.Sound.ActorEvent.Move && this.Math.rand(1, 100) <= 50)
			return;

		this.actor.playSound(_type, _volume, _pitch);
	}

	function onDamageReceived( _attacker, _skill, _hitInfo )
	{
		if (this.m.IsHeadless)
			_hitInfo.BodyPart = this.Const.BodyPart.Body;

		if (_hitInfo.DamageRegular >= 25 && this.m.UndeadType == this.Const.Necro.UndeadType.Vampire)
			this.m.WasInjured = true;

		return this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
	}

	function checkMorale( _change, _difficulty, _type = this.Const.MoraleCheckType.Default, _showIconBeforeMoraleIcon = "", _noNewLine = false )
	{
		this.actor.checkMorale( _change, _difficulty, _type, _showIconBeforeMoraleIcon, _noNewLine);
	}

	function isReallyKilled( _fatalityType )
	{
		local isVampire = this.m.UndeadType == this.Const.Necro.UndeadType.Vampire;
		local isMummy = this.m.UndeadType == this.Const.Necro.UndeadType.Mummy;
		local isZombie = this.m.UndeadType == this.Const.Necro.UndeadType.Zombie;
		local isNotZombie = this.m.UndeadType == this.Const.Necro.UndeadType.Skeleton || this.m.UndeadType == this.Const.Necro.UndeadType.Mummy;

		if (isVampire)
			return true;

		if (this.Tactical.State.isAutoRetreat())
			return true;

		if (!this.m.IsResurrectingOnFatality)
		{
			if (isZombie && (_fatalityType == this.Const.FatalityType.Decapitated || _fatalityType != this.Const.FatalityType.Smashed))
				return true;

			if (isNotZombie && _fatalityType == this.Const.FatalityType.Decapitated && this.m.ChanceToTakeNoInjury != 100)
				return true;
		}

		local chance = this.Const.Combat.SurviveWithInjuryChance * this.m.CurrentProperties.SurviveWithInjuryChanceMult;

		if (this.World.Assets.m.IsSurvivalGuaranteed && !this.m.Skills.hasSkillOfType(this.Const.SkillType.PermanentInjury))
			chance = 100;

		if (this.m.CanAutoResurrect)
			chance = 100;

		if (this.Math.rand(1, 100) <= chance)
		{
			local potential = [];

			if (_fatalityType == this.Const.FatalityType.Decapitated && !this.getSkills.hasSkill("injury.missing_head"))
			{
				local skill = this.new("scripts/skills/injury_permanent/missing_head_injury");
				this.m.Skills.add(skill);
				this.Tactical.getSurvivorRoster().add(this);
				this.m.IsDying = false;
				return false;
			}

			if (this.Math.rand(1, 100) <= this.m.ChanceToTakeNoInjury)
			{
				this.Tactical.getSurvivorRoster().add(this);
				this.m.IsDying = false;
				return false;
			}

			foreach ( inj in this.m.PotentialPermanentInjuries )
				if (!this.getSkills().hasSkill(inj.ID))
					potential.push(inj);

			if (potential.len() == 0)
				return true;

			local skill = this.new("scripts/skills/" + potential[this.Math.rand(0, potential.len() - 1)].Script);
			this.m.Skills.add(skill);
			this.Tactical.getSurvivorRoster().add(this);
			this.m.IsDying = false;
			return false;
		}

		return true;
	}

	function kill( _killer = null, _skill = null, _fatalityType = this.Const.FatalityType.None, _silent = false )
	{
		if (this.World.Assets.m.IsSurvivalGuaranteed && _fatalityType != this.Const.FatalityType.Kraken && _fatalityType != this.Const.FatalityType.Devoured && !this.m.Skills.hasSkillOfType(this.Const.SkillType.PermanentInjury))
			_fatalityType = this.Const.FatalityType.None;

		if (!this.isAlive())
			return;

		if (_killer != null && !_killer.isAlive())
			_killer = null;

		this.m.IsDying = true;
		this.m.IsReallyDead  = this.isReallyKilled(_fatalityType);

		if (!this.m.IsReallyDead )
		{
			_fatalityType = this.Const.FatalityType.Unconscious;
			this.logDebug(this.getName() + " has fallen and can\'t get up.");
		}
		else
			this.logDebug(this.getName() + " has died.");

		if (!_silent)
			this.playSound(this.Const.Sound.ActorEvent.Death, this.Const.Sound.Volume.Actor * this.m.SoundVolume[this.Const.Sound.ActorEvent.Death] * this.m.SoundVolumeOverall, this.m.SoundPitch);

		local myTile = this.isPlacedOnMap() ? this.getTile() : null;
		local tile = this.findTileToSpawnCorpse(_killer);
		this.m.Skills.onDeath(_fatalityType);
		this.onDeath(_killer, _skill, tile, _fatalityType);

		if (!this.Tactical.State.isFleeing() && _killer != null)
			_killer.onActorKilled(this, tile, _skill);

		if (_killer != null && !_killer.isHiddenToPlayer() && !this.isHiddenToPlayer())
		{
			if (this.m.IsReallyDead )
			{
				if (_killer.getID() != this.getID())
					this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_killer) + " has killed " + this.Const.UI.getColorizedEntityName(this));
				else
					this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this) + " has died");
			}
			else if (_killer.getID() != this.getID())
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_killer) + " has struck down " + this.Const.UI.getColorizedEntityName(this));
			else
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this) + " has fallen and can\'t get up");
		}

		if (!this.Tactical.State.isFleeing() && myTile != null)
		{
			local actors = this.Tactical.Entities.getAllInstances();

			foreach( i in actors )
				foreach( a in i )
					if (a.getID() != this.getID())
						a.onOtherActorDeath(_killer, this, _skill);
		}

		if (!this.isHiddenToPlayer())
		{
			if (tile != null)
			{
				if (_fatalityType == this.Const.FatalityType.Decapitated)
					this.spawnDecapitateSplatters(tile, 1.0 * this.m.DecapitateBloodAmount);
				else if (_fatalityType == this.Const.FatalityType.Smashed && (this.getFlags().has("human") || this.getFlags().has("zombie_minion")))
					this.spawnSmashSplatters(tile, 1.0);
				else
				{
					this.spawnBloodSplatters(tile, this.Const.Combat.BloodSplattersAtDeathMult * this.m.DeathBloodAmount);

					if (!this.getTile().isSameTileAs(tile))
						this.spawnBloodSplatters(this.getTile(), this.Const.Combat.BloodSplattersAtOriginalPosMult);
				}
			}
			else if (myTile != null)
				this.spawnBloodSplatters(this.getTile(), this.Const.Combat.BloodSplattersAtDeathMult * this.m.DeathBloodAmount);
		}

		if (tile != null)
			this.spawnBloodPool(tile, this.Math.rand(this.Const.Combat.BloodPoolsAtDeathMin, this.Const.Combat.BloodPoolsAtDeathMax));

		this.m.IsTurnDone = true;
		this.m.IsAlive = false;

		if (this.m.WorldTroop != null && ("Party" in this.m.WorldTroop) && this.m.WorldTroop.Party != null && !this.m.WorldTroop.Party.isNull())
			this.m.WorldTroop.Party.removeTroop(this.m.WorldTroop);
		
		this.World.Contracts.onActorKilled(this, _killer, this.Tactical.State.getStrategicProperties().CombatID);
		this.World.Events.onActorKilled(this, _killer, this.Tactical.State.getStrategicProperties().CombatID);

		if (this.Tactical.State.getStrategicProperties() != null && this.Tactical.State.getStrategicProperties().IsArenaMode)
		{
			if (_killer == null || _killer.getID() == this.getID())
				this.Sound.play(this.Const.Sound.ArenaFlee[this.Math.rand(0, this.Const.Sound.ArenaFlee.len() - 1)], this.Const.Sound.Volume.Tactical * this.Const.Sound.Volume.Arena);
			else
				this.Sound.play(this.Const.Sound.ArenaKill[this.Math.rand(0, this.Const.Sound.ArenaKill.len() - 1)], this.Const.Sound.Volume.Tactical * this.Const.Sound.Volume.Arena);
		}

		if (this.isPlayerControlled())
		{
			if (this.m.IsReallyDead )
			{
				if (this.isGuest())
					this.World.getGuestRoster().remove(this);
				else
					this.World.getPlayerRoster().remove(this);
			}

			if (this.Tactical.Entities.getHostilesNum() != 0)
				this.Tactical.Entities.setLastCombatResult(this.Const.Tactical.CombatResult.PlayerDestroyed);
			else
				this.Tactical.Entities.setLastCombatResult(this.Const.Tactical.CombatResult.EnemyDestroyed);
		}
		else
		{
			if (!this.Tactical.State.isAutoRetreat())
				this.Tactical.Entities.setLastCombatResult(this.Const.Tactical.CombatResult.EnemyDestroyed);

			if (_killer != null && _killer.isPlayerControlled() && !this.Tactical.State.isScenarioMode() && this.World.FactionManager.getFaction(this.getFaction()) != null && !this.World.FactionManager.getFaction(this.getFaction()).isTemporaryEnemy())
				this.World.FactionManager.getFaction(this.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationUnitKilled);
		}

		if (this.m.IsReallyDead )
		{
			if (!this.Tactical.State.isScenarioMode() && this.isPlayerControlled() && !this.isGuest())
			{
				local roster = this.World.getPlayerRoster().getAll();

				foreach( bro in roster )
					if (bro.isAlive() && !bro.isDying() && bro.getCurrentProperties().IsAffectedByDyingAllies)
						bro.worsenMood(0.5, this.getName() + " died in battle");
			}

			this.die();
		}
		else
			this.removeFromMap();

		if (this.m.Items != null)
		{
			this.m.Items.onActorDied(tile);

			if (this.m.IsReallyDead)
				this.m.Items.setActor(null);
		}

		this.onAfterDeath(myTile);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		local stub = this.Tactical.getCasualtyRoster().create("scripts/entity/tactical/player_corpse_stub");
		stub.setCommander(this.isCommander());
		stub.setOriginalID(this.getID());
		stub.setName(this.getNameOnly());
		stub.setTitle(this.getTitle());
		stub.setCombatStats(this.m.CombatStats);
		stub.setLifetimeStats(this.m.LifetimeStats);
		stub.m.DaysWithCompany = this.getDaysWithCompany();
		stub.m.Level = this.getLevel();
		stub.m.DailyCost = this.getDailyCost();
		this.setPlayerCorpseStubAppearance(stub, _skill, _fatalityType);

		if (_tile != null)
		{
			this.onUndeadDeath(_killer, _skill, _tile, _fatalityType);
			this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
		}

		this.World.Assets.addScore(-5 * this.getLevel());

		if (_fatalityType != this.Const.FatalityType.Unconscious && (_skill != null && _killer != null || _fatalityType == this.Const.FatalityType.Devoured || _fatalityType == this.Const.FatalityType.Kraken))
		{
			local killedBy;

			if (_fatalityType == this.Const.FatalityType.Devoured)
				killedBy = "Devoured by a Nachzehrer";
			else if (_fatalityType == this.Const.FatalityType.Kraken)
				killedBy = "Devoured by a Kraken";
			else if (_fatalityType == this.Const.FatalityType.Suicide)
				killedBy = "Committed Suicide";
			else if (_skill.isType(this.Const.SkillType.StatusEffect))
				killedBy = _skill.getKilledString();
			else if (_killer.getID() == this.getID())
				killedBy = "Killed in battle";
			else
			{
				if (_fatalityType == this.Const.FatalityType.Decapitated)
					killedBy = "Beheaded";
				else if (_fatalityType == this.Const.FatalityType.Disemboweled)
				{
					if (this.Math.rand(1, 2) == 1)
						killedBy = "Disemboweled";
					else
						killedBy = "Gutted";
				}
				else
					killedBy = _skill.getKilledString();

				killedBy = killedBy + (" by " + _killer.getKilledName());
			}

			this.World.Statistics.addFallen(this, killedBy);
		}
	}

	function setPlayerCorpseStubAppearance( _stub, _skill, _fatalityType )
	{
		local appearance = this.getItems().getAppearance();
		local sprite_body = this.getSprite("body");
		local sprite_head = this.getSprite("head");
		local sprite_hair = this.getSprite("hair");
		local sprite_beard = this.getSprite("beard");
		local sprite_beard_top = this.getSprite("beard_top");
		local tattoo_body = this.getSprite("tattoo_body");
		local tattoo_head = this.getSprite("tattoo_head");
		local sprite_surcoat = this.getSprite("surcoat");
		local sprite_accessory = this.getSprite("accessory");
		local isNotZombie = this.m.UndeadType != this.Const.Necro.UndeadType.Zombie;

		if (this.Const.BloodPoolDecals[this.m.BloodType].len() != 0)
		{
			_stub.addSprite("blood_1").setBrush(this.Const.BloodPoolDecals[this.m.BloodType][this.Math.rand(0, this.Const.BloodPoolDecals[this.m.BloodType].len() - 1)]);
			_stub.setSpriteOffset("blood_1", this.createVec(0, -15));
		}

		if (this.Const.BloodDecals[this.m.BloodType].len() != 0)
		{
			_stub.addSprite("blood_2").setBrush(this.Const.BloodDecals[this.m.BloodType][this.Math.rand(0, this.Const.BloodDecals[this.m.BloodType].len() - 1)]);
			_stub.setSpriteOffset("blood_2", this.createVec(0, -30));
		}

		if (_fatalityType == this.Const.FatalityType.Devoured || _fatalityType == this.Const.FatalityType.Kraken)
		{
			for( local i = 0; i != this.Const.CorpsePart.len(); i = ++i )
				_stub.addSprite("stuff_" + i).setBrush(this.Const.CorpsePart[i]);
		}
		else if (this.m.UndeadType == this.Const.Necro.UndeadType.Vampire)
		{
			local decal = _stub.addSprite("body");
			decal.setBrush("bust_skeleton_vampire_dead");
			return;
		}
		else
		{
			local decal = _stub.addSprite("body");

			if (this.m.UndeadType == this.Const.Necro.UndeadType.Mummy)
				decal.setBrush("mummy_dead");
			else
				decal.setBrush(sprite_body.getBrush().Name + "_dead");
			
			decal.Color = sprite_head.Color;
			decal.Saturation = sprite_head.Saturation;

			if (tattoo_body.HasBrush)
			{
				decal = _stub.addSprite("tattoo_body");
				decal.setBrush(tattoo_body.getBrush().Name + "_dead");
				decal.Color = tattoo_body.Color;
				decal.Saturation = tattoo_body.Saturation;
			}

			if (appearance.CorpseArmor != "")
			{
				decal = _stub.addSprite("armor");
				local armorDecal = appearance.CorpseArmor;

				if (isNotZombie && this.doesBrushExist(appearance.CorpseArmor + "_skeleton"))
					armorDecal = appearance.CorpseArmor + "_skeleton";

				decal.setBrush(armorDecal);
			}

			if (sprite_surcoat.HasBrush)
			{
				decal = _stub.addSprite("surcoat");
				decal.setBrush("surcoat_" + (this.m.Surcoat < 10 ? "0" + this.m.Surcoat : this.m.Surcoat) + "_dead");
			}

			if (appearance.CorpseArmorUpgradeBack != "")
			{
				decal = _stub.addSprite("upgrade_back");
				decal.setBrush(appearance.CorpseArmorUpgradeBack);
			}

			if (sprite_accessory.HasBrush)
			{
				decal = _stub.addSprite("accessory");
				decal.setBrush(sprite_accessory.getBrush().Name + "_dead");
			}

			if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				local armorDecal = appearance.Corpse + "_arrows";

				if (appearance.CorpseArmor != "" && isNotZombie && this.doesBrushExist(appearance.CorpseArmor + "_skeleton"))
					armorDecal = appearance.CorpseArmor + "_skeleton_arrows";
				else if (appearance.CorpseArmor != "")
					armorDecal = appearance.CorpseArmor + "_arrows";

				if (this.doesBrushExist(armorDecal))
					_stub.addSprite("arrows").setBrush(armorDecal);
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				local armorDecal = appearance.Corpse + "_javelin";

				if (appearance.CorpseArmor != "" && isNotZombie && this.doesBrushExist(appearance.CorpseArmor + "_skeleton"))
					armorDecal = appearance.CorpseArmor + "_skeleton_javelin";
				else if (appearance.CorpseArmor != "")
					armorDecal = appearance.CorpseArmor + "_javelin";

				if (this.doesBrushExist(armorDecal))
					_stub.addSprite("arrows").setBrush(armorDecal);
			}

			if (_fatalityType != this.Const.FatalityType.Decapitated && !this.m.IsHeadless)
			{
				if (!appearance.HideCorpseHead)
				{
					decal = _stub.addSprite("head");
					decal.setBrush(sprite_head.getBrush().Name + "_dead");
					decal.Color = sprite_head.Color;
					decal.Saturation = sprite_head.Saturation;

					if (tattoo_head.HasBrush)
					{
						decal = _stub.addSprite("tattoo_head");
						decal.setBrush(this.getSprite("tattoo_head").getBrush().Name + "_dead");
						decal.Color = tattoo_head.Color;
						decal.Saturation = tattoo_head.Saturation;
					}
				}

				if (!appearance.HideBeard && !appearance.HideCorpseHead && sprite_beard.HasBrush)
				{
					decal = _stub.addSprite("beard");
					decal.setBrush(sprite_beard.getBrush().Name + "_dead");
					decal.Color = sprite_beard.Color;
					decal.Saturation = sprite_beard.Saturation;
				}

				if (!appearance.HideHair && !appearance.HideCorpseHead && sprite_hair.HasBrush)
				{
					decal = _stub.addSprite("hair");
					decal.setBrush(sprite_hair.getBrush().Name + "_dead");
					decal.Color = sprite_hair.Color;
					decal.Saturation = sprite_hair.Saturation;
				}

				if (_fatalityType == this.Const.FatalityType.Smashed && !isNotZombie)
					_stub.addSprite("smashed").setBrush("bust_head_smashed_01");
				else if (appearance.HelmetCorpse != "")
				{
					decal = _stub.addSprite("helmet");
					decal.setBrush(this.getItems().getAppearance().HelmetCorpse);
				}

				if (!appearance.HideBeard && !appearance.HideCorpseHead && sprite_beard_top.HasBrush)
				{
					decal = _stub.addSprite("beard_top");
					decal.setBrush(sprite_beard_top.getBrush().Name + "_dead");
					decal.Color = sprite_beard.Color;
					decal.Saturation = sprite_beard.Saturation;
				}
			}

			if (appearance.CorpseArmorUpgradeFront != "")
			{
				decal = _stub.addSprite("upgrade_front");
				decal.setBrush(appearance.CorpseArmorUpgradeFront);
			}
		}
	}

	function onUndeadDeath(_killer, _skill, _tile, _fatalityType)
	{
		local flip = this.Math.rand(0, 100) < 50;
		this.m.IsCorpseFlipped = flip;
		local isResurrectable = false;
		local isVampire = this.m.UndeadType == this.Const.Necro.UndeadType.Vampire;
		local isMummy = this.m.UndeadType == this.Const.Necro.UndeadType.Mummy;
		local isZombie = this.m.UndeadType == this.Const.Necro.UndeadType.Zombie;
		local isNotZombie = this.m.UndeadType == this.Const.Necro.UndeadType.Skeleton || this.m.UndeadType == this.Const.Necro.UndeadType.Mummy;
		local appearance = this.getItems().getAppearance();
		local sprite_body = this.getSprite("body");
		local sprite_head = this.getSprite("head");
		local sprite_face = this.getSprite("scar_head");
		local sprite_hair = this.getSprite("hair");
		local sprite_beard = this.getSprite("beard");
		local sprite_beard_top = this.getSprite("beard_top");
		local tattoo_body = this.getSprite("tattoo_body");
		local tattoo_head = this.getSprite("tattoo_head");

		if (this.m.IsReallyDead)
			isResurrectable = false;

		if (!isVampire && this.m.IsResurrectingOnFatality)
			isResurrectable = true;
		else if (isZombie && _fatalityType != this.Const.FatalityType.Decapitated && _fatalityType != this.Const.FatalityType.Smashed)
			isResurrectable = true;
		else if (isNotZombie && _fatalityType != this.Const.FatalityType.Decapitated)
			isResurrectable = true;

		if (_tile != null)
		{	
			if (!isVampire)
			{
				local decal = _tile.spawnDetail(isMummy ? "mummy_dead" : sprite_body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Color = sprite_body.Color;
				decal.Saturation = sprite_body.Saturation;
				decal.Scale = 0.9;
				decal.setBrightness(0.9);

				if (tattoo_body.HasBrush)
				{
					decal = _tile.spawnDetail(tattoo_body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Color = tattoo_body.Color;
					decal.Saturation = tattoo_body.Saturation;
					decal.Scale = 0.9;
					decal.setBrightness(0.9);
				}

				if (appearance.CorpseArmor != "")
				{
					local armorDecal = appearance.CorpseArmor;

					if (isNotZombie && this.doesBrushExist(appearance.CorpseArmor + "_skeleton"))
						armorDecal = appearance.CorpseArmor + "_skeleton";

					local decal = _tile.spawnDetail(armorDecal, this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Scale = 0.9;
					decal.setBrightness(0.9);
				}

				if (isZombie)
				{
					if (this.m.Surcoat != null)
					{
						decal = _tile.spawnDetail("surcoat_" + (this.m.Surcoat < 10 ? "0" + this.m.Surcoat : this.m.Surcoat) + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
						decal.Scale = 0.9;
						decal.setBrightness(0.9);
					}

					if (appearance.CorpseArmorUpgradeBack != "")
					{
						decal = _tile.spawnDetail(appearance.CorpseArmorUpgradeBack, this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
						decal.Scale = 0.9;
						decal.setBrightness(0.9);
					}
				}

				if (_fatalityType != this.Const.FatalityType.Decapitated && !this.m.IsHeadless)
				{
					if (!appearance.HideCorpseHead)
					{
						local decal = _tile.spawnDetail(sprite_head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
						decal.Color = sprite_head.Color;
						decal.Saturation = sprite_head.Saturation;
						decal.Scale = 0.9;
						decal.setBrightness(0.9);

						if (tattoo_head.HasBrush)
						{
							local decal = _tile.spawnDetail(tattoo_head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
							decal.Color = tattoo_head.Color;
							decal.Saturation = tattoo_head.Saturation;
							decal.Scale = 0.9;
							decal.setBrightness(0.9);
						}
					}

					if (!appearance.HideBeard && !appearance.HideCorpseHead && sprite_beard.HasBrush)
					{
						local decal = _tile.spawnDetail(sprite_beard.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
						decal.Color = sprite_beard.Color;
						decal.Saturation = sprite_beard.Saturation;
						decal.Scale = 0.9;
						decal.setBrightness(0.9);

						if (sprite_beard_top.HasBrush)
						{
							local decal = _tile.spawnDetail(sprite_beard_top.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
							decal.Color = sprite_beard.Color;
							decal.Saturation = sprite_beard.Saturation;
							decal.Scale = 0.9;
							decal.setBrightness(0.9);
						}
					}

					if (!appearance.HideCorpseHead)
					{
						local decal = _tile.spawnDetail(isZombie ? "zombify_0" + this.m.InjuryType + "_dead" : sprite_face.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
						decal.Scale = 0.9;
						decal.Saturation = sprite_face.Saturation;
						decal.setBrightness(0.75);
					}

					if (!appearance.HideHair && !appearance.HideCorpseHead && sprite_hair.HasBrush)
					{
						local decal = _tile.spawnDetail(sprite_hair.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
						decal.Color = sprite_hair.Color;
						decal.Saturation = sprite_hair.Saturation;
						decal.Scale = 0.9;
						decal.setBrightness(0.9);
					}

					if (isZombie && _fatalityType == this.Const.FatalityType.Smashed)
					{
						local decal = _tile.spawnDetail("bust_head_smashed_02", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
						decal.setBrightness(0.8);
					}
					else if (appearance.HelmetCorpse != "")
					{
						local decal = _tile.spawnDetail(appearance.HelmetCorpse, this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
						decal.Scale = 0.9;
						decal.setBrightness(0.9);
					}
				}
				else if (_fatalityType == this.Const.FatalityType.Decapitated && !this.m.IsHeadless)
				{
					local layers = [];

					if (!appearance.HideCorpseHead)
						layers.push(sprite_head.getBrush().Name + "_dead");

					if (!appearance.HideCorpseHead && tattoo_head.HasBrush)
						layers.push(sprite_head.getBrush().Name + "_dead");

					if (!appearance.HideBeard && sprite_beard.HasBrush)
						layers.push(sprite_beard.getBrush().Name + "_dead");

					if (!appearance.HideCorpseHead)
						layers.push(isZombie ? "zombify_0" + this.m.InjuryType + "_dead" : sprite_face.getBrush().Name + "_dead");

					if (!appearance.HideHair && sprite_hair.HasBrush)
						layers.push(sprite_hair.getBrush().Name + "_dead");

					if (appearance.HelmetCorpse.len() != 0)
						layers.push(appearance.HelmetCorpse);

					if (!appearance.HideBeard && sprite_beard_top.HasBrush)
						layers.push(sprite_beard_top.getBrush().Name + "_dead");

					local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, isZombie ? this.createVec(0, 0) : this.createVec(-20, 15), -90.0, isZombie ? "bust_head_dead_bloodpool_zombified" : "");
					local idx = 0;

					if (!appearance.HideCorpseHead)
					{
						decap[idx].Color = sprite_head.Color;
						decap[idx].Saturation = sprite_head.Saturation;
						decap[idx].Scale = 0.9;
						decap[idx].setBrightness(0.9);
						idx = ++idx;

						if (tattoo_head.HasBrush)
						{
							decap[idx].Color = tattoo_head.Color;
							decap[idx].Saturation = tattoo_head.Saturation;
							decap[idx].Scale = 0.9;
							decap[idx].setBrightness(0.9);
							idx = ++idx;
						}
					}

					if (!appearance.HideCorpseHead)
					{
						decap[idx].Scale = 0.9;
						decap[idx].setBrightness(0.75);
						idx = ++idx;
					}

					if (!appearance.HideHair && sprite_hair.HasBrush)
					{
						decap[idx].Color = sprite_hair.Color;
						decap[idx].Saturation = sprite_hair.Saturation;
						decap[idx].Scale = 0.9;
						decap[idx].setBrightness(0.9);
						idx = ++idx;
					}

					if (appearance.HelmetCorpse.len() != 0)
					{
						decap[idx].Scale = 0.9;
						decap[idx].setBrightness(0.9);
						idx = ++idx;
					}

					if (!appearance.HideBeard && sprite_beard_top.HasBrush)
					{
						decap[idx].Color = sprite_beard.Color;
						decap[idx].Saturation = sprite_beard.Saturation;
						decap[idx].Scale = 0.9;
						decap[idx].setBrightness(0.9);
					}
				}

				if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
				{
					local armorDecal = appearance.Corpse + "_arrows";

					if (appearance.CorpseArmor != "" && isNotZombie && this.doesBrushExist(appearance.CorpseArmor + "_skeleton"))
						armorDecal = appearance.CorpseArmor + "_skeleton_arrows";
					else if (appearance.CorpseArmor != "")
						armorDecal = appearance.CorpseArmor + "_arrows";

					if (this.doesBrushExist(armorDecal))
					{
						decal = _tile.spawnDetail(armorDecal, this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
						decal.Saturation = 0.85;
						decal.setBrightness(0.85);
					}
				}
				else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
				{
					local armorDecal = appearance.Corpse + "_javelin";

					if (appearance.CorpseArmor != "" && isNotZombie && this.doesBrushExist(appearance.CorpseArmor + "_skeleton"))
						armorDecal = appearance.CorpseArmor + "_skeleton_javelin";
					else if (appearance.CorpseArmor != "")
						armorDecal = appearance.CorpseArmor + "_javelin";
			
					if (this.doesBrushExist(armorDecal))
					{
						decal = _tile.spawnDetail(armorDecal, this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
						decal.Saturation = 0.85;
						decal.setBrightness(0.85);
					}
				}

				if (isZombie && appearance.CorpseArmorUpgradeFront != "")
				{
					decal = _tile.spawnDetail(appearance.CorpseArmorUpgradeFront, this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Scale = 0.9;
					decal.setBrightness(0.9);
				}
			}
			else
			{
				local decal = _tile.spawnDetail("bust_skeleton_vampire_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			this.spawnTerrainDropdownEffect(_tile);
			local custom;

			if (isZombie)
			{
				this.spawnFlies(_tile);
				custom = {
					IsZombified = true,
					InjuryType = this.m.InjuryType,
					Face = sprite_head.getBrush().Name,
					Body = sprite_body.getBrush().Name,
					TattooBody = tattoo_body.HasBrush ? tattoo_body.getBrush().Name : null,
					TattooHead = tattoo_head.HasBrush ? tattoo_head.getBrush().Name : null,
					Hair = sprite_hair.HasBrush ? sprite_hair.getBrush().Name : null,
					HairColor = sprite_hair.Color,
					HairSaturation = sprite_hair.Saturation,
					Beard = sprite_beard.HasBrush ? sprite_beard.getBrush().Name : null,
					Surcoat = this.m.Surcoat,
					Ethnicity = 0
				};
			}

			if (isNotZombie)
			{
				custom = {
					Face = sprite_face.getBrush().Name,
					Body = sprite_body.getBrush().Name,
					Hair = sprite_hair.HasBrush ? sprite_hair.getBrush().Name : null,
					HairColor = sprite_hair.Color,
					HairSaturation = sprite_hair.Saturation,
					Beard = sprite_beard.HasBrush ? sprite_beard.getBrush().Name : null,
					BodyColor = sprite_body.Color,
					BodySaturation = sprite_body.Saturation
				};
			}

			local corpse = clone this.Const.Corpse;
			corpse.Type = this.m.ResurrectWithScript;
			corpse.Faction = this.getFaction();
			corpse.CorpseName = this.getName();
			corpse.Tile = _tile;
			corpse.Value = this.m.ResurrectionValue;
			corpse.IsResurrectable = isResurrectable;
			corpse.IsConsumable = _fatalityType != this.Const.FatalityType.Unconscious && isZombie;
			corpse.Armor = this.m.BaseProperties.Armor;
			corpse.Items = _fatalityType != this.Const.FatalityType.Unconscious ? this.getItems() : null;
			corpse.Color = sprite_body.Color;
			corpse.Saturation = sprite_body.Saturation;
			corpse.Custom = custom;
			corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated && !this.m.IsHeadless;
			corpse.IsPlayer = true;
			corpse.PlayerID <- this.getID();

			if (isResurrectable && this.m.CanAutoResurrect)
			{
				corpse.IsConsumable = false;
				corpse.IsResurrectable = false;
				this.m.CanAutoResurrect = false;
				this.Time.scheduleEvent(this.TimeUnit.Rounds, 1, this.Tactical.Entities.resurrect, corpse);
			}

			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		if (_fatalityType != this.Const.FatalityType.Unconscious)
			this.getItems().dropAll(_tile, _killer, !flip);
	}

	function onResurrected( _info )
	{
		if (!_info.IsHeadAttached && this.m.IsResurrectingOnFatality)
			this.setHeadLess(true);

		foreach ( skill in this.getSkills().m.Skills )
			if (skill.isType(this.Const.SkillType.DamageOverTime) || skill.m.IsRemovedAfterBattle)
				skill.removeSelf();

		this.actor.onResurrected(_info);
		this.m.IsResurrected = true;
		this.pickupMeleeWeaponAndShield(this.getTile());
		this.getSkills().update();
		this.getSkills().onCombatStarted();

		local roster = this.World.getPlayerRoster().getAll();
		local dead = this.Tactical.getCasualtyRoster().getAll();
		this.Tactical.getSurvivorRoster().remove(this);

		foreach( bro in roster )
			if (bro.isAlive() && !bro.isDying() && bro.getCurrentProperties().IsAffectedByDyingAllies)
				bro.improveMood(0.5, this.getName() + " resurrected in battle");

		foreach( i, d in dead )
		{
			if (this.getID() == d.getOriginalID())
			{
				this.Tactical.getCasualtyRoster().remove(d);
				break;
			}
		}

		local tile = this.getTile();

		for( local i = 0; i != 6; i = ++i )
		{
			if (!tile.hasNextTile(i))
			{
			}
			else
			{
				local otherTile = tile.getNextTile(i);

				if (!otherTile.IsOccupiedByActor)
				{
				}
				else
				{
					local otherActor = otherTile.getEntity();
					local numEnemies = otherTile.getZoneOfControlCountOtherThan(otherActor.getAlliedFactions());

					if (otherActor.m.MaxEnemiesThisTurn < numEnemies && !otherActor.isAlliedWith(this))
					{
						local difficulty = this.Math.maxf(10.0, -this.getLevel());
						otherActor.checkMorale(-1, difficulty);
						otherActor.m.MaxEnemiesThisTurn = numEnemies;
					}
				}
			}
		}
	}

	function onUpdateInjuryLayer()
	{
		local p = this.m.Hitpoints / this.getHitpointsMax();
		local injury = this.getSprite("injury");
		local injury_body = this.getSprite("injury_body");

		switch (this.m.UndeadType)
		{
			case this.Const.Necro.UndeadType.Zombie:
			if (p > 0.5)
				if (!injury.HasBrush || injury.getBrush().Name != "zombify_0" + this.m.InjuryType)
					injury.setBrush("zombify_0" + this.m.InjuryType);
			else if (!injury.HasBrush || injury.getBrush().Name != "zombify_0" + this.m.InjuryType + "_injured")
				injury.setBrush("zombify_0" + this.m.InjuryType + "_injured");

			if (p > 0.5)
			{
				injury_body.setBrush("zombify_body_01");
				injury_body.Visible = true;
			}
			else
			{
				injury_body.setBrush("zombify_body_02");
				injury_body.Visible = true;
			}

			this.setDirty(true);
			break;
			
			case this.Const.Necro.UndeadType.Vampire:
		
			if (p <= 0.33)
			{
				this.getSprite("body").setBrush("bust_skeleton_body_03");
				this.getSprite("injury_body").setBrush("bust_skeleton_body_03_injured");
				this.getSprite("head").setBrush("bust_skeleton_head_03");
				this.getSprite("injury").setBrush("bust_skeleton_head_03_injured");
			}
			else if (p <= 0.66)
			{
				this.getSprite("body").setBrush("bust_skeleton_body_04");
				this.getSprite("injury_body").setBrush("bust_skeleton_body_04_injured");
				this.getSprite("head").setBrush("bust_skeleton_head_04");
				this.getSprite("injury").setBrush("bust_skeleton_head_04_injured");
			}
			else
			{
				this.getSprite("body").setBrush("bust_skeleton_body_05");
				this.getSprite("injury_body").setBrush("bust_skeleton_body_05_injured");
				this.getSprite("head").setBrush("bust_skeleton_head_05");
				this.getSprite("injury").setBrush("bust_skeleton_head_05_injured");
			}
		
			this.getSprite("injury_body").Visible = this.m.WasInjured;
			this.getSprite("injury").Visible = this.m.WasInjured;
			
			this.setDirty(true);
			break;
			
			default:
			this.actor.onUpdateInjuryLayer();
		}
	}

	function onFactionChanged()
	{
		this.player.onFactionChanged();
		this.getSprite("status_rage").setHorizontalFlipping(!this.isAlliedWithPlayer());
	}

	function addDefaultStatusSprites()
	{
		local rage = this.addSprite("status_rage");
		rage.setBrush("mind_control");
		rage.Visible = false;
		this.addSprite("miniboss");
		local hex = this.addSprite("status_hex");
		hex.Visible = false;
		local sweat = this.addSprite("status_sweat");
		local stunned = this.addSprite("status_stunned");
		stunned.setBrush(this.Const.Combat.StunnedBrush);
		stunned.Visible = false;
		local shield_icon = this.addSprite("shield_icon");
		shield_icon.Visible = false;
		local arms_icon = this.addSprite("arms_icon");
		arms_icon.Visible = false;
		local rooted = this.addSprite("status_rooted");
		rooted.Visible = false;
		rooted.Scale = this.getSprite("status_rooted_back").Scale;
		local morale = this.addSprite("morale");
		morale.Visible = false;
	}

	function onInit()
	{
		this.player.onInit();
		local b = this.m.BaseProperties;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.DailyWageMult = 0.0;
		b.MoraleEffectMult = 0.0;
		b.FatigueEffectMult = 0.0;
		this.m.Skills.update();
	}

	function setStartValuesEx( _backgrounds, _addTraits = true, _gender = -1, _addEquipment = true )
	{
		_backgrounds = this.Const.Necro.CommonUndeadBackgrounds;

		local background = this.new("scripts/skills/backgrounds/" + _backgrounds[this.Math.rand(0, _backgrounds.len() - 1)]);
		this.m.Skills.add(background);
		background.buildDescription();
		
		if (background.getID() == "background.skeleton")
			this.m.UndeadType = this.Const.Necro.UndeadType.Skeleton;
		
		if (background.getID() == "background.mummy")
			this.m.UndeadType = this.Const.Necro.UndeadType.Mummy;
		
		if (background.getID() == "background.vampire")
			this.m.UndeadType = this.Const.Necro.UndeadType.Vampire;
		
		this.m.StarWeights = background.buildAttributes(null, null);
		background.buildDescription();
		
		local inTraining = this.new("scripts/skills/traits/intensive_training_trait");
		local maxTraits = 0;

		if (!this.getSkills().hasSkill("trait.intensive_training_trait"))
			this.m.Skills.add(inTraining);

		if (_addTraits)
		{
			local maxTraits = 2;
			local traits = [
				background
			];

			if (background.m.IsGuaranteed.len() > 0)
			{
				maxTraits = maxTraits - background.m.IsGuaranteed.len();
				foreach(trait in background.m.IsGuaranteed)
					traits.push(this.new("scripts/skills/traits/" + trait));
			}

			pickTraits( traits, maxTraits );
			
			for( local i = 1; i < traits.len(); i = ++i )
			{
				this.m.Skills.add(traits[i]);

				if (traits[i].getContainer() != null)
					traits[i].addTitle();
			}
		}

		if (_addEquipment)
			background.addEquipment();
		
		this.setUndeadAppearance();
		this.setUndeadAttributes();		
		
		if (_addTraits)
		{
			this.fillTalentValues(3);
			this.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
		}
		
		local attributes = background.buildPerkTree();

		this.m.Skills.update();
	}
	
	function setUndeadAppearance()
	{
		switch (this.m.UndeadType)
		{
		case this.Const.Necro.UndeadType.Skeleton:
			local hairColor = this.Const.HairColors.Zombie[this.Math.rand(0, this.Const.HairColors.Zombie.len() - 1)];
			local body = this.getSprite("body");
			body.setBrush("bust_skeleton_body_0" + this.Math.rand(1, 2));
			body.Saturation = 0.8;
			if (this.Math.rand(0, 100) < 75)
				body.varySaturation(0.2);
			if (this.Math.rand(0, 100) < 90)
				body.varyColor(0.025, 0.025, 0.025);

			this.m.BloodColor = body.Color;
			this.m.BloodSaturation = body.Saturation;
			this.getSprite("injury_body").setBrush("bust_skeleton_body_injured");

			local head = this.getSprite("head");
			head.setBrush("bust_skeleton_head");
			head.Color = body.Color;
			head.Saturation = body.Saturation;

			local injury = this.getSprite("injury");
			injury.setBrush("bust_skeleton_head_injured");

			local beard = this.getSprite("beard");
			beard.varyColor(0.02, 0.02, 0.02);
			if (this.Math.rand(1, 100) <= 25)
				beard.setBrush("beard_" + hairColor + "_" + this.Const.Beards.ZombieOnly[this.Math.rand(0, this.Const.Beards.ZombieOnly.len() - 1)]);

			local face = this.getSprite("scar_head");
			face.setBrush("bust_skeleton_face_0" + this.Math.rand(1, 6));

			local hair = this.getSprite("hair");
			hair.Color = beard.Color;
			if (this.Math.rand(1, 100) <= 50)
				hair.setBrush("hair_" + hairColor + "_" + this.Const.Hair.ZombieOnly[this.Math.rand(0, this.Const.Hair.ZombieOnly.len() - 1)]);
			this.setSpriteOffset("hair", this.createVec(0, -3));
			
			local beard_top = this.getSprite("beard_top");
			if (beard.HasBrush && this.doesBrushExist(beard.getBrush().Name + "_top"))
			{
				beard_top.setBrush(beard.getBrush().Name + "_top");
				beard_top.Color = beard.Color;
			}
			break;
		
		case this.Const.Necro.UndeadType.Vampire:
			local hairColor = this.Const.HairColors.Zombie[this.Math.rand(0, this.Const.HairColors.Zombie.len() - 1)];
			local body = this.getSprite("body");
			body.setBrush("bust_skeleton_body_05");
			this.getSprite("injury_body").setBrush("bust_skeleton_body_05_injured");
			
			local body_detail = this.getSprite("tattoo_body");
			if (this.Math.rand(1, 100) <= 75)
				body_detail.setBrush("bust_skeleton_detail_0" + this.Math.rand(2, 3));

			local head = this.getSprite("head");
			head.setBrush("bust_skeleton_head_05");
			head.Color = body.Color;
			head.Saturation = body.Saturation;

			local injury = this.getSprite("injury");
			injury.setBrush("bust_skeleton_head_05_injured");

			local head_detail = this.getSprite("tattoo_head");
			if (this.Math.rand(1, 100) <= 50)
				head_detail.setBrush("bust_skeleton_head_detail_01");

			local beard = this.getSprite("beard");
			beard.setBrightness(0.7);
			beard.varyColor(0.02, 0.02, 0.02);

			local hair = this.getSprite("hair");
			hair.Color = beard.Color;
			if (this.Math.rand(1, 100) <= 75)
			{
				local idx = this.Math.rand(0, this.Const.Hair.Vampire.len());
				if (idx = this.Const.Hair.Vampire.len())
					hair.setBrush("bust_vampire_lord_hair_01")
				else
					hair.setBrush("hair_" + hairColor + "_" + this.Const.Hair.Vampire[idx]);
			}
			this.setSpriteOffset("hair", this.createVec(0, -3));

			local beard_top = this.getSprite("beard_top");

			if (beard.HasBrush && this.doesBrushExist(beard.getBrush().Name + "_top"))
			{
				beard_top.setBrush(beard.getBrush().Name + "_top");
				beard_top.Color = beard.Color;
			}
			break;

		case this.Const.Necro.UndeadType.Mummy:
			local hairColor = this.Const.HairColors.Zombie[this.Math.rand(0, this.Const.HairColors.Zombie.len() - 1)];
			local body = this.getSprite("body");
			body.setBrush("mummy_body_01");
			
			this.m.BloodColor = body.Color;
			this.m.BloodSaturation = body.Saturation;
			local head = this.getSprite("head");
			head.setBrush("bust_skeleton_head_03");
			head.Color = body.Color;
			head.Saturation = body.Saturation;

			local injury = this.getSprite("injury");
			injury.setBrush("bust_skeleton_head_injured");

			local beard = this.getSprite("beard");
			beard.varyColor(0.02, 0.02, 0.02);
			if (this.Math.rand(1, 100) <= 25)
				beard.setBrush("beard_" + hairColor + "_" + this.Const.Beards.ZombieOnly[this.Math.rand(0, this.Const.Beards.ZombieOnly.len() - 1)]);

			local face = this.getSprite("scar_head");
			face.setBrush("mummy_head_0" + this.Math.rand(1, 9));

			local hair = this.getSprite("hair");
			hair.Color = beard.Color;
			if (this.Math.rand(1, 100) <= 50)
				hair.setBrush("hair_" + hairColor + "_" + this.Const.Hair.ZombieOnly[this.Math.rand(0, this.Const.Hair.ZombieOnly.len() - 1)]);
			this.setSpriteOffset("hair", this.createVec(0, -3));

			local beard_top = this.getSprite("beard_top");
			if (beard.HasBrush && this.doesBrushExist(beard.getBrush().Name + "_top"))
			{
				beard_top.setBrush(beard.getBrush().Name + "_top");
				beard_top.Color = beard.Color;
			}
			break;

		default:
			this.m.InjuryType = this.Math.rand(1, 4);
			local hairColor = this.Const.HairColors.Zombie[this.Math.rand(0, this.Const.HairColors.Zombie.len() - 1)];
			local body = this.getSprite("body");
			body.Saturation = 0.5;
			body.varySaturation(0.2);
			body.Color = this.createColor("#c1ddaa");
			body.varyColor(0.05, 0.05, 0.05);

			local tattoo_body = this.getSprite("tattoo_body");
			tattoo_body.Saturation = 0.9;
			tattoo_body.setBrightness(0.75);

			local injury_body = this.getSprite("injury_body");
			injury_body.Visible = true;
			injury_body.setBrightness(0.75);
			injury_body.setBrush("zombify_body_01");
		
			local head = this.getSprite("head");
			head.setBrush(this.Const.Faces.AllHuman[this.Math.rand(0, this.Const.Faces.AllHuman.len() - 1)]);
			head.Saturation = body.Saturation;
			head.Color = body.Color;

			local tattoo_head = this.getSprite("tattoo_head");
			tattoo_head.Saturation = 0.9;
			tattoo_head.setBrightness(0.75);

			local beard = this.getSprite("beard");
			beard.varyColor(0.02, 0.02, 0.02);
			if (this.Math.rand(1, 100) <= 50)
			{
				if (this.m.InjuryType == 4)
				{
					beard.setBrush("beard_" + hairColor + "_" + this.Const.Beards.ZombieExtended[this.Math.rand(0, this.Const.Beards.ZombieExtended.len() - 1)]);
					beard.setBrightness(0.9);
				}
				else
					beard.setBrush("beard_" + hairColor + "_" + this.Const.Beards.Zombie[this.Math.rand(0, this.Const.Beards.Zombie.len() - 1)]);
			}

			local injury = this.getSprite("injury");
			injury.setBrush("zombify_0" + this.m.InjuryType);
			injury.setBrightness(0.75);

			local hair = this.getSprite("hair");
			hair.Color = beard.Color;
			if (this.Math.rand(0, this.Const.Hair.Zombie.len()) != this.Const.Hair.Zombie.len())
				hair.setBrush("hair_" + hairColor + "_" + this.Const.Hair.Zombie[this.Math.rand(0, this.Const.Hair.Zombie.len() - 1)]);

			local beard_top = this.getSprite("beard_top");
			if (beard.HasBrush && this.doesBrushExist(beard.getBrush().Name + "_top"))
			{
				beard_top.setBrush(beard.getBrush().Name + "_top");
				beard_top.Color = beard.Color;
			}

			this.getSprite("arms_icon").setBrightness(0.85);
		}

		local body_blood = this.getSprite("body_blood");
		body_blood.setBrush("bust_body_bloodied_02");
		body_blood.Visible = this.Math.rand(1, 100) <= 33;
		local body_dirt = this.getSprite("dirt");
		body_dirt.setBrush("bust_body_dirt_02");
		body_dirt.Visible = this.Math.rand(1, 100) <= 33;
		this.m.BodySpriteName = this.getSprite("body").getBrush().Name;
		this.setDirty(true);
	}
	
	function setUndeadAttributes()
	{
		switch (this.m.UndeadType)
		{
		case this.Const.Necro.UndeadType.Skeleton:
			this.setSkeletonAttributes();
			break;
		case this.Const.Necro.UndeadType.Vampire:
			this.setVampireAttributes();
			break;
		case this.Const.Necro.UndeadType.Mummy:
			this.setMummyAttributes();
			break;
		default:
			this.setZombieAttributes();
		}
		
		if (this.m.BodySpriteName != "")
		{
			local app = this.getItems().getAppearance();
			app.Body = this.m.BodySpriteName;
			app.Corpse = this.m.BodySpriteName + "_dead";
		}

		this.m.PotentialPermanentInjuries.extend(this.Const.Necro.InjuryPermanent[this.m.UndeadType]);
		this.m.Skills.update();
	}

	function setSkeletonAttributes()
	{
		this.m.BloodType = this.Const.BloodType.Bones;
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/skeleton_hurt_01.wav",
			"sounds/enemies/skeleton_hurt_02.wav",
			"sounds/enemies/skeleton_hurt_03.wav",
			"sounds/enemies/skeleton_hurt_04.wav",
			"sounds/enemies/skeleton_hurt_06.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/skeleton_death_01.wav",
			"sounds/enemies/skeleton_death_02.wav",
			"sounds/enemies/skeleton_death_03.wav",
			"sounds/enemies/skeleton_death_04.wav",
			"sounds/enemies/skeleton_death_05.wav",
			"sounds/enemies/skeleton_death_06.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Resurrect] = [
			"sounds/enemies/skeleton_rise_01.wav",
			"sounds/enemies/skeleton_rise_02.wav",
			"sounds/enemies/skeleton_rise_03.wav",
			"sounds/enemies/skeleton_rise_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/skeleton_idle_01.wav",
			"sounds/enemies/skeleton_idle_02.wav",
			"sounds/enemies/skeleton_idle_03.wav",
			"sounds/enemies/skeleton_idle_04.wav",
			"sounds/enemies/skeleton_idle_05.wav",
			"sounds/enemies/skeleton_idle_06.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/skeleton_idle_01.wav",
			"sounds/enemies/skeleton_idle_02.wav",
			"sounds/enemies/skeleton_idle_03.wav",
			"sounds/enemies/skeleton_idle_04.wav",
			"sounds/enemies/skeleton_idle_05.wav",
			"sounds/enemies/skeleton_idle_06.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = this.m.Sound[this.Const.Sound.ActorEvent.Move];
		this.m.Flags.add("skeleton");
		this.m.Skills.add(this.new("scripts/skills/racial/skeleton_racial"));
		this.m.Skills.add(this.new("scripts/skills/traits/legend_fleshless_trait"));
	}

	function setVampireAttributes()
	{
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/vampire_hurt_01.wav",
			"sounds/enemies/vampire_hurt_02.wav",
			"sounds/enemies/vampire_hurt_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/vampire_death_01.wav",
			"sounds/enemies/vampire_death_02.wav",
			"sounds/enemies/vampire_death_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/vampire_idle_01.wav",
			"sounds/enemies/vampire_idle_02.wav",
			"sounds/enemies/vampire_idle_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = this.m.Sound[this.Const.Sound.ActorEvent.Idle];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = this.m.Sound[this.Const.Sound.ActorEvent.Idle];
		this.m.Flags.add("vampire");
		this.m.Skills.add(this.new("scripts/skills/racial/vampire_racial"));
	}

	function setMummyAttributes()
	{
		this.m.BloodType = this.Const.BloodType.Bones;
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/mummy_hurt_01.wav",
			"sounds/enemies/mummy_hurt_02.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/mummy_die_01.wav",
			"sounds/enemies/mummy_die_02.wav",
			"sounds/enemies/mummy_die_03.wav",
			"sounds/enemies/mummy_die_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Resurrect] = [
			"sounds/enemies/skeleton_rise_01.wav",
			"sounds/enemies/skeleton_rise_02.wav",
			"sounds/enemies/skeleton_rise_03.wav",
			"sounds/enemies/skeleton_rise_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/mummy_idle_01.wav",
			"sounds/enemies/mummy_idle_02.wav",
			"sounds/enemies/mummy_idle_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/mummy_idle_01.wav",
			"sounds/enemies/mummy_idle_02.wav",
			"sounds/enemies/mummy_idle_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = this.m.Sound[this.Const.Sound.ActorEvent.Idle];
		this.m.Flags.add("skeleton");
		this.m.Skills.add(this.new("scripts/skills/racial/mummy_racial"));
		this.m.Skills.add(this.new("scripts/skills/traits/legend_fleshless_trait"));
	}

	function setZombieAttributes()
	{
		this.m.BloodType = this.Const.BloodType.Dark;
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/zombie_hurt_01.wav",
			"sounds/enemies/zombie_hurt_02.wav",
			"sounds/enemies/zombie_hurt_03.wav",
			"sounds/enemies/zombie_hurt_04.wav",
			"sounds/enemies/zombie_hurt_05.wav",
			"sounds/enemies/zombie_hurt_06.wav",
			"sounds/enemies/zombie_hurt_07.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/zombie_death_01.wav",
			"sounds/enemies/zombie_death_02.wav",
			"sounds/enemies/zombie_death_03.wav",
			"sounds/enemies/zombie_death_04.wav",
			"sounds/enemies/zombie_death_05.wav",
			"sounds/enemies/zombie_death_06.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Resurrect] = [
			"sounds/enemies/zombie_rise_01.wav",
			"sounds/enemies/zombie_rise_02.wav",
			"sounds/enemies/zombie_rise_03.wav",
			"sounds/enemies/zombie_rise_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/zombie_idle_01.wav",
			"sounds/enemies/zombie_idle_02.wav",
			"sounds/enemies/zombie_idle_03.wav",
			"sounds/enemies/zombie_idle_04.wav",
			"sounds/enemies/zombie_idle_05.wav",
			"sounds/enemies/zombie_idle_06.wav",
			"sounds/enemies/zombie_idle_07.wav",
			"sounds/enemies/zombie_idle_08.wav",
			"sounds/enemies/zombie_idle_09.wav",
			"sounds/enemies/zombie_idle_10.wav",
			"sounds/enemies/zombie_idle_11.wav",
			"sounds/enemies/zombie_idle_12.wav",
			"sounds/enemies/zombie_idle_13.wav",
			"sounds/enemies/zombie_idle_14.wav",
			"sounds/enemies/zombie_idle_15.wav",
			"sounds/enemies/zombie_idle_16.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = this.m.Sound[this.Const.Sound.ActorEvent.Idle];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = this.m.Sound[this.Const.Sound.ActorEvent.Idle];
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Move] = 0.1;
		this.m.SoundPitch = this.Math.rand(70, 120) * 0.01;
		this.m.Flags.add("zombie_minion");
		this.m.Skills.add(this.new("scripts/skills/actives/zombie_bite"));
		this.m.Skills.add(this.new("scripts/skills/traits/legend_rotten_flesh_trait"));
	}

	function onSerialize( _out )
	{
		this.player.onSerialize(_out);
		_out.writeU8(this.m.UndeadType);
		_out.writeU8(this.m.InjuryType);
		_out.writeString(this.m.BodySpriteName);
		//_out.writeBool(this.m.IsHeadless);
		this.setUndeadAttributes();
	}

	function onDeserialize( _in )
	{
		this.player.onDeserialize(_in);
		this.m.UndeadType = _in.readU8();
		this.m.InjuryType = _in.readU8();
		this.m.BodySpriteName = _in.readString();
		//this.m.IsHeadless = _in.readBool();
	}

});