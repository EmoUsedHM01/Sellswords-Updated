this.ghost_player <- this.inherit("scripts/entity/tactical/undead_player", {
	m = {
		DistortTargetA = null,
		DistortTargetPrevA = this.createVec(0, 0),
		DistortAnimationStartTimeA = 0,
		DistortTargetB = null,
		DistortTargetPrevB = this.createVec(0, 0),
		DistortAnimationStartTimeB = 0,
		DistortTargetC = null,
		DistortTargetPrevC = this.createVec(0, 0),
		DistortAnimationStartTimeC = 0,
		DistortTargetD = null,
		DistortTargetPrevD = this.createVec(0, 0),
		DistortAnimationStartTimeD = 0
	},

	function improveMood( _a = 1.0, _reason = "" )
	{
		if (this.m.UndeadType != this.Const.Necro.UndeadType.DemonHound)
			this.player.improveMood(_a, _reason);
		else
		{
			this.m.Mood = 3.0;
			this.getSkills().update();
		}
	}

	function worsenMood( _a = 1.0, _reason = "" )
	{
		if (this.m.UndeadType != this.Const.Necro.UndeadType.DemonHound)
			this.player.worsenMood(_a, _reason);
		else
		{
			this.m.Mood = 3.0;
			this.getSkills().update();
		}
	}

	function recoverMood()
	{
		if (this.m.UndeadType != this.Const.Necro.UndeadType.DemonHound)
			this.player.recoverMood();
	}

	function create()
	{
		this.player.create();
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.ExcludedInjuries = [ // this is redundant, will remove later
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
		this.m.Items.getData()[this.Const.ItemSlot.Body][0] = -1;
		this.m.Items.getData()[this.Const.ItemSlot.Head][0] = -1;
		this.m.Items.getData()[this.Const.ItemSlot.Mainhand][0] = -1;
		this.m.Items.getData()[this.Const.ItemSlot.Offhand][0] = -1;
		this.m.Items.getData()[this.Const.ItemSlot.Ammo][0] = -1;
	}

	function onDamageReceived( _attacker, _skill, _hitInfo )
	{
		local ret = this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
		
		if (this.isDying() || this.m.UndeadType != this.Const.Necro.UndeadType.DemonHound)
			return ret;
		
		if (this.Tactical.TurnSequenceBar.getActiveEntity() == null || this.Tactical.TurnSequenceBar.getActiveEntity().getID() != this.getID())
			return ret;
		
		local result = {
			TargetTile = this.getTile(),
			Destinations = []
		};
		
		this.Tactical.queryTilesInRange(this.getTile(), 2, 6, false, [], this.onQueryTiles, result);
		
		if (result.Destinations.len() == 0)
			return ret;
		
		local targetTile = result.Destinations[this.Math.rand(0, result.Destinations.len() - 1)]
		local tag = {
			User = this,
			TargetTile = targetTile,
			OnDone = this.onTeleportDone,
			OnFadeIn = this.onFadeIn,
			OnFadeDone = this.onFadeDone,
			OnTeleportStart = this.onTeleportStart,
			IgnoreColors = false
		};
		
		if (this.getTile().IsVisibleForPlayer)
		{
			local effect = {
				Delay = 0,
				Quantity = 12,
				LifeTimeQuantity = 12,
				SpawnRate = 100,
				Brushes = [
					"bust_demon_hound_essence"
				],
				Stages = [
					{
						LifeTimeMin = 0.7,
						LifeTimeMax = 0.7,
						ColorMin = this.createColor("ffffff5f"),
						ColorMax = this.createColor("ffffff5f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						SpawnOffsetMin = this.createVec(-10, -10),
						SpawnOffsetMax = this.createVec(10, 10),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.7,
						LifeTimeMax = 0.7,
						ColorMin = this.createColor("ffffff2f"),
						ColorMax = this.createColor("ffffff2f"),
						ScaleMin = 0.9,
						ScaleMax = 0.9,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.1,
						ColorMin = this.createColor("ffffff00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 0.9,
						ScaleMax = 0.9,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					}
				]
			};
			this.Tactical.spawnParticleEffect(false, effect.Brushes, this.getTile(), effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 40));
			this.storeSpriteColors();
			this.fadeTo(this.createColor("ffffff00"), 0);
			this.onTeleportStart(tag);
		}
		else if (targetTile.IsVisibleForPlayer)
		{
			this.storeSpriteColors();
			this.fadeTo(this.createColor("ffffff00"), 0);
			this.onTeleportStart(tag);
		}
		else
		{
			tag.IgnoreColors = true;
			this.onTeleportStart(tag);
		}
	}

	function onQueryTiles( _tile, _tag )
	{
		if (!_tile.IsEmpty)
			return;

		_tag.Destinations.push(_tile);
	}

	function onTeleportStart( _tag )
	{
		this.Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, _tag.OnDone, _tag, false, 0.0);
	}

	function onTeleportDone( _entity, _tag )
	{
		if (!_entity.isHiddenToPlayer())
		{
			local effect1 = {
				Delay = 0,
				Quantity = 4,
				LifeTimeQuantity = 4,
				SpawnRate = 100,
				Brushes = [
					"bust_demon_hound_essence"
				],
				Stages = [
					{
						LifeTimeMin = 0.4,
						LifeTimeMax = 0.4,
						ColorMin = this.createColor("ffffff5f"),
						ColorMax = this.createColor("ffffff5f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(0.0, -1.0),
						DirectionMax = this.createVec(0.0, -1.0),
						SpawnOffsetMin = this.createVec(-10, 40),
						SpawnOffsetMax = this.createVec(10, 50),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.4,
						LifeTimeMax = 0.4,
						ColorMin = this.createColor("ffffff2f"),
						ColorMax = this.createColor("ffffff2f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(0.0, -1.0),
						DirectionMax = this.createVec(0.0, -1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.1,
						ColorMin = this.createColor("ffffff00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(0.0, -1.0),
						DirectionMax = this.createVec(0.0, -1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					}
				]
			};
			local effect2 = {
				Delay = 0,
				Quantity = 4,
				LifeTimeQuantity = 4,
				SpawnRate = 100,
				Brushes = [
					"bust_demon_hound_essence"
				],
				Stages = [
					{
						LifeTimeMin = 0.4,
						LifeTimeMax = 0.4,
						ColorMin = this.createColor("ffffff5f"),
						ColorMax = this.createColor("ffffff5f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(1.0, 0.0),
						DirectionMax = this.createVec(1.0, 0.0),
						SpawnOffsetMin = this.createVec(-40, -10),
						SpawnOffsetMax = this.createVec(-50, 10),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.4,
						LifeTimeMax = 0.4,
						ColorMin = this.createColor("ffffff2f"),
						ColorMax = this.createColor("ffffff2f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(1.0, 0.0),
						DirectionMax = this.createVec(1.0, 0.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.1,
						ColorMin = this.createColor("ffffff00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(1.0, 0.0),
						DirectionMax = this.createVec(1.0, 0.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					}
				]
			};
			local effect3 = {
				Delay = 0,
				Quantity = 4,
				LifeTimeQuantity = 4,
				SpawnRate = 100,
				Brushes = [
					"bust_demon_hound_essence"
				],
				Stages = [
					{
						LifeTimeMin = 0.4,
						LifeTimeMax = 0.4,
						ColorMin = this.createColor("ffffff5f"),
						ColorMax = this.createColor("ffffff5f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, 0.0),
						DirectionMax = this.createVec(-1.0, 0.0),
						SpawnOffsetMin = this.createVec(40, 10),
						SpawnOffsetMax = this.createVec(50, 10),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.4,
						LifeTimeMax = 0.4,
						ColorMin = this.createColor("ffffff2f"),
						ColorMax = this.createColor("ffffff2f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, 0.0),
						DirectionMax = this.createVec(-1.0, 0.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.1,
						ColorMin = this.createColor("ffffff00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, 0.0),
						DirectionMax = this.createVec(-1.0, 0.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					}
				]
			};
			this.Tactical.spawnParticleEffect(false, effect1.Brushes, _entity.getTile(), effect1.Delay, effect1.Quantity, effect1.LifeTimeQuantity, effect1.SpawnRate, effect1.Stages, this.createVec(0, 40));
			this.Tactical.spawnParticleEffect(false, effect2.Brushes, _entity.getTile(), effect2.Delay, effect2.Quantity, effect2.LifeTimeQuantity, effect2.SpawnRate, effect2.Stages, this.createVec(0, 40));
			this.Tactical.spawnParticleEffect(false, effect3.Brushes, _entity.getTile(), effect3.Delay, effect3.Quantity, effect3.LifeTimeQuantity, effect3.SpawnRate, effect3.Stages, this.createVec(0, 40));
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 400, _tag.OnFadeIn, _tag);
		}
		else
			_tag.OnFadeIn(_tag);
	}
	
	function onFadeIn( _tag )
	{
		if (!_tag.IgnoreColors)
		{
			if (_tag.User.isHiddenToPlayer())
				_tag.User.restoreSpriteColors();
			else
			{
				_tag.User.fadeToStoredColors(300);
				this.Time.scheduleEvent(this.TimeUnit.Virtual, 300, _tag.OnFadeDone, _tag);
			}
		}
	}
	
	function onFadeDone( _tag )
	{
		_tag.User.restoreSpriteColors();
	}
	
	function isReallyKilled( _fatalityType )
	{
		if (this.m.UndeadType != this.Const.Necro.UndeadType.DemonHound)
			return true;

		if (this.Tactical.State.isAutoRetreat())
			return true;

		local chance = this.Const.Combat.SurviveWithInjuryChance * this.m.CurrentProperties.SurviveWithInjuryChanceMult;

		if (this.World.Assets.m.IsSurvivalGuaranteed && !this.m.Skills.hasSkillOfType(this.Const.SkillType.PermanentInjury))
			chance = 100;

		if (this.m.CanAutoResurrect)
			chance = 100;

		if (this.Math.rand(1, 100) <= chance)
		{
			local potential = [];

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

	function setPlayerCorpseStubAppearance( _stub, _skill, _fatalityType )
	{
		local appearance = this.getItems().getAppearance();
		local sprite_body = this.getSprite("body");
		local sprite_head = this.getSprite("head");
		local sprite_accessory = this.getSprite("accessory");
		local isNotZombie = this.m.UndeadType != this.Const.Necro.UndeadType.Zombie;

		if (this.m.UndeadType != this.Const.Necro.UndeadType.DemonHound)
			_stub.addSprite("blood_1").setBrush("loot_bag");
		else
		{
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
				for( local i = 0; i != this.Const.CorpsePart.len(); i = ++i )
					_stub.addSprite("stuff_" + i).setBrush(this.Const.CorpsePart[i]);
			else
			{
				local decal = _stub.addSprite("body");
				decal.setBrush("bust_demon_hound_dead");
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}
		}
	}

	function onUndeadDeath(_killer, _skill, _tile, _fatalityType)
	{
		local flip = this.Math.rand(0, 100) < 50;
		this.m.IsCorpseFlipped = flip;

		if (_tile != null && this.m.UndeadType == this.Const.Necro.UndeadType.DemonHound)
		{
			local decal = _tile.spawnDetail("bust_demon_hound_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false);
			decal.Scale = 0.9;
			decal.setBrightness(0.9);

			this.spawnTerrainDropdownEffect(_tile);
			local corpse = clone this.Const.Corpse;
			local isResurrectable = false;
			corpse.Type = this.m.ResurrectWithScript;
			corpse.Faction = this.getFaction();
			corpse.CorpseName = this.getName();
			corpse.Tile = _tile;
			corpse.Value = this.m.ResurrectionValue;
			corpse.IsResurrectable = isResurrectable;
			corpse.IsConsumable = false;
			corpse.Armor = this.m.BaseProperties.Armor;
			corpse.Items = _fatalityType != this.Const.FatalityType.Unconscious ? this.getItems() : null;
			corpse.IsHeadAttached = false;
			corpse.IsPlayer = true;
			corpse.PlayerID <- this.getID();
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		if (_fatalityType != this.Const.FatalityType.Unconscious)
			this.getItems().dropAll(_tile, _killer, !flip);

		this.spawnOnDeathEffect(_tile);
	}

	function spawnOnDeathEffect( _tile )
	{
		if (_tile == null)
			_tile = this.getTile();

		local effect;
		switch (this.m.UndeadType)
		{
		case this.Const.Necro.UndeadType.DemonHound:
			effect = {
				Delay = 0,
				Quantity = 12,
				LifeTimeQuantity = 12,
				SpawnRate = 100,
				Brushes = [
					"bust_demon_hound_essence"
				],
				Stages = [
					{
						LifeTimeMin = 1.0,
						LifeTimeMax = 1.0,
						ColorMin = this.createColor("ffffff5f"),
						ColorMax = this.createColor("ffffff5f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						SpawnOffsetMin = this.createVec(-10, -10),
						SpawnOffsetMax = this.createVec(10, 10),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 1.0,
						LifeTimeMax = 1.0,
						ColorMin = this.createColor("ffffff2f"),
						ColorMax = this.createColor("ffffff2f"),
						ScaleMin = 0.9,
						ScaleMax = 0.9,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.1,
						ColorMin = this.createColor("ffffff00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 0.1,
						ScaleMax = 0.1,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					}
				]
			};
			break;

		case this.Const.Necro.UndeadType.Banshee:
			effect = {
				Delay = 0,
				Quantity = 12,
				LifeTimeQuantity = 12,
				SpawnRate = 100,
				Brushes = [
					"bust_banshee_01"
				],
				Stages = [
					{
						LifeTimeMin = 1.0,
						LifeTimeMax = 1.0,
						ColorMin = this.createColor("ffffff5f"),
						ColorMax = this.createColor("ffffff5f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						SpawnOffsetMin = this.createVec(-10, -10),
						SpawnOffsetMax = this.createVec(10, 10),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 1.0,
						LifeTimeMax = 1.0,
						ColorMin = this.createColor("ffffff2f"),
						ColorMax = this.createColor("ffffff2f"),
						ScaleMin = 0.9,
						ScaleMax = 0.9,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.1,
						ColorMin = this.createColor("ffffff00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 0.1,
						ScaleMax = 0.1,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					}
				]
			};
			break;
		
		default:
			effect = {
				Delay = 0,
				Quantity = 12,
				LifeTimeQuantity = 12,
				SpawnRate = 100,
				Brushes = [
					"bust_ghost_01"
				],
				Stages = [
					{
						LifeTimeMin = 1.0,
						LifeTimeMax = 1.0,
						ColorMin = this.createColor("ffffff5f"),
						ColorMax = this.createColor("ffffff5f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						SpawnOffsetMin = this.createVec(-10, -10),
						SpawnOffsetMax = this.createVec(10, 10),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 1.0,
						LifeTimeMax = 1.0,
						ColorMin = this.createColor("ffffff2f"),
						ColorMax = this.createColor("ffffff2f"),
						ScaleMin = 0.9,
						ScaleMax = 0.9,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.1,
						ColorMin = this.createColor("ffffff00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 0.1,
						ScaleMax = 0.1,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					}
				]
			};
		}

		this.Tactical.spawnParticleEffect(false, effect.Brushes, _tile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 40));
	}

	function resetRenderEffects()
	{
		this.m.IsRaising = false;
		this.m.IsSinking = false;
		this.m.IsRaisingShield = false;
		this.m.IsLoweringShield = false;
		this.m.IsRaisingWeapon = false;
		this.m.IsLoweringWeapon = false;
		this.setSpriteOffset("shield_icon", this.createVec(0, 0));
		this.setSpriteOffset("arms_icon", this.createVec(0, 0));
		this.getSprite("arms_icon").Rotation = 0;
		this.getSprite("status_rooted").Visible = false;
		this.getSprite("status_rooted_back").Visible = false;
	}

	function onUpdateInjuryLayer()
	{
		if (this.m.UndeadType == this.Const.Necro.UndeadType.DemonHound)
			this.actor.onUpdateInjuryLayer();
		else
			this.setDirty(true);
	}

	function onFactionChanged()
	{
		this.actor.onFactionChanged();
		local flip = !this.isAlliedWithPlayer();
		this.getSprite("background").setHorizontalFlipping(flip);
		this.getSprite("quiver").setHorizontalFlipping(flip);
		this.getSprite("fog").setHorizontalFlipping(!flip);
		this.getSprite("body").setHorizontalFlipping(!flip);
		this.getSprite("injury_body").setHorizontalFlipping(!flip);
		this.getSprite("shaft").setHorizontalFlipping(flip);
		this.getSprite("head").setHorizontalFlipping(!flip);
		this.getSprite("blur_1").setHorizontalFlipping(!flip);
		this.getSprite("blur_2").setHorizontalFlipping(!flip);

		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			if (!this.hasSprite(a))
				continue;
			this.getSprite(a).setHorizontalFlipping(flip);
		}

		this.getSprite("body_blood").setHorizontalFlipping(flip);
		this.getSprite("accessory").setHorizontalFlipping(flip);
		this.getSprite("accessory_special").setHorizontalFlipping(flip);
		this.getSprite("dirt").setHorizontalFlipping(flip);
		this.getSprite("status_rage").setHorizontalFlipping(flip);
	}

	function setStartValuesEx( _backgrounds, _addTraits = true, _gender = -1, _addEquipment = true )
	{
		_backgrounds = this.Const.Necro.GhostUndeadBackgrounds;

		local background = this.new("scripts/skills/backgrounds/" + _backgrounds[this.Math.rand(0, _backgrounds.len() - 1)]);
		this.m.Skills.add(background);
		background.buildDescription();

		if (background.getID() == "background.ghost")
			this.m.UndeadType = this.Const.Necro.UndeadType.Ghost;

		if (background.getID() == "background.banshee")
			this.m.UndeadType = this.Const.Necro.UndeadType.Banshee;

		if (background.getID() == "background.demon_hound")
			this.m.UndeadType = this.Const.Necro.UndeadType.DemonHound;

		this.m.StarWeights = background.buildAttributes(null, null);
		background.buildDescription();
		
		local inTraining = this.new("scripts/skills/traits/legend_intensive_training_trait");
		local maxTraits = 0;

		if (!this.getSkills().hasSkill("trait.legend_intensive_training_trait"))
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

		this.getFlags().set("max_lives", 2);
		this.setUndeadAppearance();
		this.setUndeadAttributes();
		background.buildDescription(true);			

		if (_addTraits)
		{
			this.fillTalentValues(3);
			this.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
		}

		local isNotDemonHound = this.m.UndeadType != this.Const.Necro.UndeadType.DemonHound;
		local attributes = background.buildPerkTree();
		this.World.Assets.getOrigin().addScenarioPerk(background, this.Const.Perks.PerkDefs.Pathfinder, 0);
		this.World.Assets.getOrigin().addScenarioPerk(background, this.Const.Perks.PerkDefs.Fearsome, 5);

		if (isNotDemonHound)
		{
			this.World.Assets.getOrigin().addScenarioPerk(background, this.Const.Perks.PerkDefs.NineLives, 0);
			this.getFlags().set("max_lives", 4);

			if (this.m.UndeadType == this.Const.Necro.UndeadType.Ghost) this.getBaseProperties().Hitpoints = this.Math.rand(1, 5);
			if (this.m.UndeadType == this.Const.Necro.UndeadType.Banshee) this.getBaseProperties().Hitpoints = this.Math.rand(5, 15);
		}

		this.m.Skills.update();
	}
	
	function onInit()
	{
		this.actor.onInit();
		this.setRenderCallbackEnabled(true);
		local b = this.m.BaseProperties;
		b.IsAffectedByNight = false;
		b.IsAffectedByRain = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.DailyWageMult = 0.0;
		b.MoraleEffectMult = 0.0;
		b.FatigueEffectMult = 0.0;
		this.m.ActionPointCosts = this.Const.SameMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		
		local app = this.getItems().getAppearance();
		app.Quiver = this.Const.Items.Default.PlayerQuiver;
		
		this.addSprite("background");
		this.addSprite("socket").setBrush("bust_base_player");
		this.addSprite("quiver");
		this.addSprite("fog")

		local body = this.addSprite("body");
		body.varySaturation(0.25);
		body.varyColor(0.2, 0.2, 0.2);

		this.addSprite("injury")

		local injury = this.addSprite("injury_body");
		injury.Visible = false;
		injury.setBrush("bust_demon_hound_injury");

		this.addSprite("shaft");

		local head = this.addSprite("head");
		head.varySaturation(0.25);
		head.varyColor(0.2, 0.2, 0.2);

		local blur_1 = this.addSprite("blur_1");
		blur_1.varySaturation(0.25);
		blur_1.varyColor(0.2, 0.2, 0.2);

		local blur_2 = this.addSprite("blur_2");
		blur_2.varySaturation(0.25);
		blur_2.varyColor(0.2, 0.2, 0.2);

		foreach (a in this.Const.CharacterSprites.Helmets)
			this.addSprite(a)

		this.addSprite("accessory");
		this.addSprite("accessory_special");
		
		local body_blood = this.addSprite("body_blood");
		body_blood.Visible = false;
		local body_dirt = this.addSprite("dirt");
		body_dirt.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.setSpriteOffset("status_rooted", this.createVec(-5, -5));
		
		this.m.Skills.add(this.new("scripts/skills/actives/wake_ally_skill"));
		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/effects/captain_effect"));
		this.m.Skills.add(this.new("scripts/skills/special/stats_collector"));
		this.m.Skills.add(this.new("scripts/skills/special/mood_check"));
		this.m.Skills.add(this.new("scripts/skills/special/weapon_breaking_warning"));
		this.m.Skills.add(this.new("scripts/skills/special/no_ammo_warning"));
		this.m.Skills.add(this.new("scripts/skills/effects/battle_standard_effect"));
		this.m.Skills.add(this.new("scripts/skills/actives/break_ally_free_skill"));
		this.m.Skills.add(this.new("scripts/skills/effects/legend_realm_of_nightmares_effect"));
		this.m.Skills.add(this.new("scripts/skills/special/legend_horserider_skill"));
		this.m.Skills.add(this.new("scripts/skills/effects/legend_veteran_levels_effect"));

		this.setFaction(this.Const.Faction.Player);
		this.m.Items.setUnlockedBagSlots(2);
		this.m.Skills.add(this.new("scripts/skills/special/bag_fatigue"));
		this.setDiscovered(true);
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, _setDirty);
	}

	function setUndeadAppearance()
	{
		switch (this.m.UndeadType)
		{
		case this.Const.Necro.UndeadType.DemonHound:
			local _body = this.Math.rand(1,3);
			local _spirit = this.Math.rand(1,3);
			local body = this.getSprite("body");
			body.setBrush("bust_demon_hound_0" + _body);
			local injury = this.getSprite("injury_body");
			injury.Visible = false;
			injury.setBrush("bust_demon_hound_injury");
			local head = this.getSprite("head");
			head.setBrush("bust_demon_hound_spirit_0" + _spirit);
			local blur_1 = this.getSprite("blur_1");
			blur_1.setBrush("bust_demon_hound_spirit_0" + _spirit);
			local blur_2 = this.getSprite("blur_2");
			blur_2.setBrush("bust_demon_hound_spirit_0" + _spirit);
			break;
		
		case this.Const.Necro.UndeadType.Banshee:
			local fog = this.getSprite("fog")
			fog.setBrush("bust_ghost_fog_02");
			local body = this.getSprite("body");
			body.setBrush("bust_banshee_01");
			local head = this.getSprite("head");
			head.setBrush("bust_banshee_01");
			local blur_1 = this.getSprite("blur_1");
			blur_1.setBrush("bust_banshee_01");
			local blur_2 = this.getSprite("blur_2");
			blur_2.setBrush("bust_banshee_01");
			break;

		default:
			local fog = this.getSprite("fog")
			fog.setBrush("bust_ghost_fog_02");
			local body = this.addSprite("body");
			body.setBrush("bust_ghost_01");
			local head = this.addSprite("head");
			head.setBrush("bust_ghost_01");
			local blur_1 = this.addSprite("blur_1");
			blur_1.setBrush("bust_ghost_01");
			local blur_2 = this.addSprite("blur_2");
			blur_2.setBrush("bust_ghost_01");
		}
		
		this.m.BodySpriteName = this.getSprite("body").getBrush().Name;
		this.setDirty(true);
	}

	function setUndeadAttributes()
	{
		switch (this.m.UndeadType)
		{
		case this.Const.Necro.UndeadType.DemonHound:
			this.setDemonHoundAttributes();
			break;
			
		case this.Const.Necro.UndeadType.Banshee:
			this.setBansheeAttributes();
			break;
			
		default:
			this.setGhostAttributes();
		}
		
		if (this.m.BodySpriteName != "")
		{
			local app = this.getItems().getAppearance();
			app.Body = this.m.BodySpriteName;
		}

		this.m.PotentialPermanentInjuries.extend(this.Const.Necro.InjuryPermanent[this.m.UndeadType]);
		this.m.Skills.update();
	}

	function setDemonHoundAttributes()
	{
		this.m.BloodType = this.Const.BloodType.Bones;
		this.m.IsEmittingMovementSounds = true;
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/hollen_hurt_01.wav",
			"sounds/enemies/hollen_hurt_02.wav",
			"sounds/enemies/hollen_hurt_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/hollen_death_01.wav",
			"sounds/enemies/hollen_death_02.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Resurrect] = [
			"sounds/enemies/skeleton_rise_01.wav",
			"sounds/enemies/skeleton_rise_02.wav",
			"sounds/enemies/skeleton_rise_03.wav",
			"sounds/enemies/skeleton_rise_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/hollen_idle_01.wav",
			"sounds/enemies/hollen_idle_02.wav",
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/hollen_charge_01.wav",
			"sounds/enemies/hollen_charge_02.wav",
			"sounds/enemies/hollen_charge_03.wav",
			"sounds/enemies/hollen_charge_04.wav",
			"sounds/enemies/hollen_charge_05.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = this.m.Sound[this.Const.Sound.ActorEvent.Move];
		this.m.SoundPitch = this.Math.rand(90, 110) * 0.01;
		this.m.Flags.add("skeleton");
		this.m.Skills.add(this.new("scripts/skills/racial/skeleton_racial"));
		this.m.Skills.add(this.new("scripts/skills/traits/legend_fleshless_trait"));
		this.m.Skills.add(this.new("scripts/skills/actives/legend_demon_hound_bite_skill"));
	}

	function setBansheeAttributes()
	{
		this.m.BloodType = this.Const.BloodType.None;
		this.m.IsEmittingMovementSounds = false;
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/banshee_hit_01.wav",
			"sounds/enemies/banshee_hit_02.wav",
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/banshee_death_01.wav",
			"sounds/enemies/banshee_death_02.wav",
			"sounds/enemies/banshee_death_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/banshee_idle_01.wav",
			"sounds/enemies/banshee_idle_02.wav",
		];
		this.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = this.m.Sound[this.Const.Sound.ActorEvent.Idle];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = this.m.Sound[this.Const.Sound.ActorEvent.Idle];
		this.m.SoundPitch = this.Math.rand(90, 110) * 0.01;
		this.m.Flags.add("ghost");
		this.m.Skills.add(this.new("scripts/skills/racial/ghost_racial"));
		this.m.Skills.add(this.new("scripts/skills/actives/mod_banshee_scream"));
		this.m.Skills.add(this.new("scripts/skills/actives/mod_ghost_possess"));
		this.m.MaxTraversibleLevels = 3;
	}

	function setGhostAttributes()
	{
		this.m.BloodType = this.Const.BloodType.None;
		this.m.IsEmittingMovementSounds = false;
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/ghost_death_01.wav",
			"sounds/enemies/ghost_death_02.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/ghost_death_01.wav",
			"sounds/enemies/ghost_death_02.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/geist_idle_13.wav",
			"sounds/enemies/geist_idle_14.wav",
			"sounds/enemies/geist_idle_15.wav",
			"sounds/enemies/geist_idle_16.wav",
			"sounds/enemies/geist_idle_17.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = this.m.Sound[this.Const.Sound.ActorEvent.Idle];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = this.m.Sound[this.Const.Sound.ActorEvent.Idle];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = this.m.Sound[this.Const.Sound.ActorEvent.Idle];
		this.m.SoundPitch = this.Math.rand(90, 110) * 0.01;
		this.m.Flags.add("ghost");
		this.m.Skills.add(this.new("scripts/skills/racial/ghost_racial"));
		this.m.Skills.add(this.new("scripts/skills/actives/ghastly_touch"));
		this.m.Skills.add(this.new("scripts/skills/actives/mod_horrific_scream"));
		this.m.Skills.add(this.new("scripts/skills/actives/mod_ghost_possess"));
		this.m.MaxTraversibleLevels = 3;
	}

	function onRender()
	{
		this.actor.onRender();

		if (this.m.UndeadType == this.Const.Necro.UndeadType.DemonHound)
		{
			if (this.m.DistortTargetA == null)
			{
				this.m.DistortTargetA = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
				this.m.DistortAnimationStartTimeA = this.Time.getVirtualTimeF();
			}

			if (this.moveSpriteOffset("head", this.m.DistortTargetPrevA, this.m.DistortTargetA, 3.8, this.m.DistortAnimationStartTimeA))
			{
				this.m.DistortAnimationStartTimeA = this.Time.getVirtualTimeF();
				this.m.DistortTargetPrevA = this.m.DistortTargetA;
				this.m.DistortTargetA = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
			}

			if (this.m.DistortTargetB == null)
			{
				this.m.DistortTargetB = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
				this.m.DistortAnimationStartTimeB = this.Time.getVirtualTimeF();
			}

			if (this.moveSpriteOffset("blur_1", this.m.DistortTargetPrevB, this.m.DistortTargetB, 4.9000001, this.m.DistortAnimationStartTimeB))
			{
				this.m.DistortAnimationStartTimeB = this.Time.getVirtualTimeF();
				this.m.DistortTargetPrevB = this.m.DistortTargetB;
				this.m.DistortTargetB = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
			}

			if (this.m.DistortTargetC == null)
			{
				this.m.DistortTargetC = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
				this.m.DistortAnimationStartTimeC = this.Time.getVirtualTimeF();
			}

			if (this.moveSpriteOffset("blur_2", this.m.DistortTargetPrevC, this.m.DistortTargetC, 4.3, this.m.DistortAnimationStartTimeC))
			{
				this.m.DistortAnimationStartTimeC = this.Time.getVirtualTimeF();
				this.m.DistortTargetPrevC = this.m.DistortTargetC;
				this.m.DistortTargetC = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
			}
		}
		else
		{
			if (this.m.DistortTargetA == null)
			{
				this.m.DistortTargetA = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
				this.m.DistortAnimationStartTimeA = this.Time.getVirtualTimeF();
			}

			if (this.moveSpriteOffset("head", this.m.DistortTargetPrevA, this.m.DistortTargetA, 3.8, this.m.DistortAnimationStartTimeA))
			{
				this.m.DistortAnimationStartTimeA = this.Time.getVirtualTimeF();
				this.m.DistortTargetPrevA = this.m.DistortTargetA;
				this.m.DistortTargetA = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
			}

			if (this.m.DistortTargetB == null)
			{
				this.m.DistortTargetB = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
				this.m.DistortAnimationStartTimeB = this.Time.getVirtualTimeF();
			}

			if (this.moveSpriteOffset("blur_1", this.m.DistortTargetPrevB, this.m.DistortTargetB, 4.9000001, this.m.DistortAnimationStartTimeB))
			{
				this.m.DistortAnimationStartTimeB = this.Time.getVirtualTimeF();
				this.m.DistortTargetPrevB = this.m.DistortTargetB;
				this.m.DistortTargetB = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
			}

			if (this.m.DistortTargetC == null)
			{
				this.m.DistortTargetC = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
				this.m.DistortAnimationStartTimeC = this.Time.getVirtualTimeF();
			}

			if (this.moveSpriteOffset("body", this.m.DistortTargetPrevC, this.m.DistortTargetC, 4.3, this.m.DistortAnimationStartTimeC))
			{
				this.m.DistortAnimationStartTimeC = this.Time.getVirtualTimeF();
				this.m.DistortTargetPrevC = this.m.DistortTargetC;
				this.m.DistortTargetC = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
			}

			if (this.m.DistortTargetD == null)
			{
				this.m.DistortTargetD = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
				this.m.DistortAnimationStartTimeD = this.Time.getVirtualTimeF();
			}

			if (this.moveSpriteOffset("blur_2", this.m.DistortTargetPrevD, this.m.DistortTargetD, 5.5999999, this.m.DistortAnimationStartTimeD))
			{
				this.m.DistortAnimationStartTimeD = this.Time.getVirtualTimeF();
				this.m.DistortTargetPrevD = this.m.DistortTargetD;
				this.m.DistortTargetD = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
			}
		}
	}

	function fillAttributeLevelUpValues( _amount, _maxOnly = false, _minOnly = false )
	{
		if (this.m.Attributes.len() == 0)
		{
			this.m.Attributes.resize(this.Const.Attributes.COUNT);

			for( local i = 0; i != this.Const.Attributes.COUNT; i = ++i )
				this.m.Attributes[i] = [];
		}

		local isGhost = this.m.UndeadType != this.Const.Necro.UndeadType.DemonHound;
		local AttributesLevelUp = [];

		if (isGhost)
		{
			AttributesLevelUp =
				[{Min = 1,Max = 1}, // Hitpoints
					{Min = 2,Max = 4}, // Bravery
						{Min = 2,Max = 4}, // Fatigue
							{Min = 3,Max = 5}, // Initiative
								{Min = 1,Max = 3}, // MeleeSkill
									{Min = 2,Max = 3}, // RangedSkill
										{Min = 1,Max = 3}, // MeleeDefense
											{Min = 2,Max = 4}]; // RangedDefense
		}
		else
		{
			AttributesLevelUp = 
				[{Min = 3,Max = 5}, // Hitpoints
					{Min = 3,Max = 4}, // Bravery
						{Min = 3,Max = 5}, // Fatigue
							{Min = 4,Max = 6}, // Initiative
								{Min = 1,Max = 4}, // MeleeSkill
									{Min = 1,Max = 1}, // RangedSkill
										{Min = 2,Max = 3}, // MeleeDefense
											{Min = 1,Max = 3}]; // RangedDefense
		}

		for( local i = 0; i != this.Const.Attributes.COUNT; i = ++i )
		{
			for( local j = 0; j < _amount; j = ++j )
			{
				if (_minOnly)
					this.m.Attributes[i].insert(0, 1);
				else if (_maxOnly)
					this.m.Attributes[i].insert(0, AttributesLevelUp[i].Max);
				else
					this.m.Attributes[i].insert(0, this.Math.rand(AttributesLevelUp[i].Min + (this.m.Talents[i] == 3 ? 2 : this.m.Talents[i]), AttributesLevelUp[i].Max + (this.m.Talents[i] == 3 ? 1 : 0)));
			}
		}
	}

	function updateInjuryVisuals( _setDirty = true )
	{
		this.setDirty(_setDirty);
	}

	function onSerialize( _out )
	{
		this.player.onSerialize(_out);
		_out.writeU16(this.m.UndeadType);
		_out.writeU16(this.m.InjuryType);
		_out.writeString(this.m.BodySpriteName);
		this.setUndeadAttributes();
	}

	function onDeserialize( _in )
	{
		this.player.onDeserialize(_in);
		this.m.UndeadType = _in.readU16();
		this.m.InjuryType = _in.readU16();
		this.m.BodySpriteName = _in.readString();
	}

});