this.dryad_lindy <- this.inherit("scripts/entity/tactical/dryad_summon_actor", {
	m = {
		Size = 1.2,
		DistortTargetA = null,
		DistortTargetPrevA = this.createVec(0, 0),
		DistortTargetB = null,
		DistortTargetPrevB = this.createVec(0, 0),
		DistortTargetC = null,
		DistortTargetPrevC = this.createVec(0, 0),
		DistortAnimationStartTimeA = 0,
		IsFlipping = false,
		Tail = null,
		Name = "Forest Avatar"
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.Schrat;
		this.m.BloodType = this.Const.BloodType.Wood;
		this.m.XP = this.Const.Tactical.Actor.Schrat.XP;
		this.m.IsActingImmediately = false;
		this.m.XP = this.Const.Tactical.Actor.LegendStollwurm.XP;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(-30, -15);
		this.m.DecapitateBloodAmount = 2.0;
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/lindwurm_hurt_01.wav",
			"sounds/enemies/lindwurm_hurt_02.wav",
			"sounds/enemies/lindwurm_hurt_03.wav",
			"sounds/enemies/lindwurm_hurt_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/lindwurm_death_01.wav",
			"sounds/enemies/lindwurm_death_02.wav",
			"sounds/enemies/lindwurm_death_03.wav",
			"sounds/enemies/lindwurm_death_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/lindwurm_flee_01.wav",
			"sounds/enemies/lindwurm_flee_02.wav",
			"sounds/enemies/lindwurm_flee_03.wav",
			"sounds/enemies/lindwurm_flee_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/lindwurm_idle_01.wav",
			"sounds/enemies/lindwurm_idle_02.wav",
			"sounds/enemies/lindwurm_idle_03.wav",
			"sounds/enemies/lindwurm_idle_04.wav",
			"sounds/enemies/lindwurm_idle_05.wav",
			"sounds/enemies/lindwurm_idle_06.wav",
			"sounds/enemies/lindwurm_idle_07.wav",
			"sounds/enemies/lindwurm_idle_08.wav",
			"sounds/enemies/lindwurm_idle_09.wav",
			"sounds/enemies/lindwurm_idle_10.wav",
			"sounds/enemies/lindwurm_idle_11.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = this.m.Sound[this.Const.Sound.ActorEvent.Idle];
		this.m.SoundVolume[this.Const.Sound.ActorEvent.DamageReceived] = 1.5;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Death] = 1.5;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Flee] = 1.5;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] = 2.0;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Move] = 1.5;
		this.m.SoundPitch = this.Math.rand(95, 105) * 0.01;
		this.getFlags().add("body_immune_to_acid");
		this.getFlags().add("head_immune_to_acid");
		this.getFlags().add("lindwurm");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/lindwurm_agent");
		this.m.AIAgent.setActor(this);
	}

	function setName( _n )
	{
		this.m.Name = _n;
	}

	function getName()
	{
		return this.m.Name;
	}

	function setVariant(_v)
	{
		this.setDirty(true);
		this.setSize(this.Math.rand(70, 90) * 0.01);
	}

	function getIdealRange()
	{
		return 2;
	}

	function getTail()
	{
		return this.m.Tail;
	}

	function playSound( _type, _volume, _pitch = 1.0 )
	{
		if (_type == this.Const.Sound.ActorEvent.Move && this.Math.rand(1, 100) <= 50)
		{
			return;
		}

		this.actor.playSound(_type, _volume, _pitch);
	}
	function setSize(_s)
	{
		this.m.Size = _s;
		this.m.DecapitateBloodAmount = _s * 0.75;
		this.getSprite("body").Scale = _s;
		this.getSprite("head").Scale = _s;
		this.getSprite("injury").Scale = _s;
		this.getSprite("status_rooted").Scale = _s * 0.65;
		this.getSprite("status_rooted_back").Scale = _s * 0.65;
		this.getSprite("legs_back").Scale = _s;
		this.getSprite("legs_front").Scale = _s;
		local offset = this.createVec(0, -10.0);
		this.setSpriteOffset("body", offset);
		this.setSpriteOffset("head", offset);
		this.setSpriteOffset("injury", offset);
		this.setSpriteOffset("status_rooted", this.createVec(7, 10 - 10.0 * (1.0 - _s)));
		this.setSpriteOffset("status_rooted_back", this.createVec(7, 10 - 10.0 * (1.0 - _s)));
		this.setSpriteOffset("legs_back", offset);
		this.setSpriteOffset("legs_front", offset);
	}
	function onRender()
	{
		this.actor.onRender();

		if (this.m.DistortTargetA == null)
		{
			this.m.DistortTargetA = this.m.IsFlipping ? this.createVec(0, 1.3 * this.m.Size) : this.createVec(0, -1.3 * this.m.Size);
			this.m.DistortTargetB = !this.m.IsFlipping ? this.createVec(-0.7 * this.m.Size, 0) : this.createVec(0.7 * this.m.Size, 0);
			this.m.DistortTargetC = !this.m.IsFlipping ? this.createVec(0.7 * this.m.Size, 0) : this.createVec(-0.7 * this.m.Size, 0);
			this.m.DistortAnimationStartTimeA = this.Time.getVirtualTimeF() - this.Math.rand(10, 100) * 0.01;
		}

		this.moveSpriteOffset("legs_back", this.m.DistortTargetPrevB, this.m.DistortTargetB, 1.0, this.m.DistortAnimationStartTimeA);
		this.moveSpriteOffset("legs_front", this.m.DistortTargetPrevC, this.m.DistortTargetC, 1.0, this.m.DistortAnimationStartTimeA);
		this.moveSpriteOffset("body", this.m.DistortTargetPrevA, this.m.DistortTargetA, 1.0, this.m.DistortAnimationStartTimeA);
		this.moveSpriteOffset("injury", this.m.DistortTargetPrevA, this.m.DistortTargetA, 1.0, this.m.DistortAnimationStartTimeA);

		if (this.moveSpriteOffset("head", this.m.DistortTargetPrevA, this.m.DistortTargetA, 1.0, this.m.DistortAnimationStartTimeA))
		{
			this.m.DistortAnimationStartTimeA = this.Time.getVirtualTimeF();
			this.m.DistortTargetPrevA = this.m.DistortTargetA;
			this.m.DistortTargetA = this.m.IsFlipping ? this.createVec(0, 1.0 * this.m.Size) : this.createVec(0, -1.0 * this.m.Size);
			this.m.DistortTargetPrevB = this.m.DistortTargetB;
			this.m.DistortTargetB = !this.m.IsFlipping ? this.createVec(-0.5 * this.m.Size, 0) : this.createVec(0.5 * this.m.Size, 0);
			this.m.DistortTargetPrevC = this.m.DistortTargetC;
			this.m.DistortTargetC = !this.m.IsFlipping ? this.createVec(0.5 * this.m.Size, 0) : this.createVec(-0.5 * this.m.Size, 0);
			this.m.IsFlipping = !this.m.IsFlipping;
		}
	}
	
	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null)
		{
			local effect = {
				Delay = 0,
				Quantity = 12,
				LifeTimeQuantity = 12,
				SpawnRate = 100,
				Brushes = [
					"bust_druid_lindy"
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
			this.Tactical.spawnParticleEffect(false, effect.Brushes, _tile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 40));
		}
		
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function kill( _killer = null, _skill = null, _fatalityType = this.Const.FatalityType.None, _silent = false )
	{
		this.m.IsDying = true;

		if (this.m.Tail != null && !this.m.Tail.isNull() && this.m.Tail.isAlive())
		{
			this.m.Tail.kill(_killer, _skill, _fatalityType, _silent);
			this.m.Tail = null;
		}

		this.actor.kill(_killer, _skill, _fatalityType, _silent);
	}

	function updateOverlay()
	{
		this.actor.updateOverlay();

		if (this.m.Tail != null && !this.m.Tail.isNull() && this.m.Tail.isAlive())
		{
			this.m.Tail.updateOverlay();
		}
	}

	function setFaction( _f )
	{
		this.actor.setFaction(_f);

		if (this.m.Tail != null && !this.m.Tail.isNull() && this.m.Tail.isAlive())
		{
			this.m.Tail.setFaction(_f);
			this.m.Tail.m.Name = this.m.Name + "\'s tail";
		}
	}

	function checkMorale( _change, _difficulty, _type = this.Const.MoraleCheckType.Default, _showIconBeforeMoraleIcon = "", _noNewLine = false )
	{
		this.actor.checkMorale(_change, _difficulty, _type, _showIconBeforeMoraleIcon, _noNewLine);

		if (this.m.Tail != null && !this.m.Tail.isNull() && this.m.Tail.isAlive())
		{
			this.m.Tail.setMoraleState(this.getMoraleState());
		}
	}

	function onActorKilled( _actor, _tile, _skill)
	{
		this.actor.onActorKilled(_actor, _tile, _skill);

		if (this.getFaction() == this.Const.Faction.Player || this.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			local XPgroup = _actor.getXPValue();
			local brothers = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);

			foreach( bro in brothers )
			{
				bro.addXP(this.Math.max(1, this.Math.floor(XPgroup / brothers.len())));
			}
		}
	}
	
	function onInit()
	{
		this.actor.onInit();
		local clouds = this.Tactical.getWeather().createCloudSettings();
		clouds.Type = this.getconsttable().CloudType.Fog;
		clouds.MinClouds = 20;
		clouds.MaxClouds = 20;
		clouds.MinVelocity = 3.0;
		clouds.MaxVelocity = 9.0;
		clouds.MinAlpha = 0.35;
		clouds.MaxAlpha = 0.45;
		clouds.MinScale = 2.0;
		clouds.MaxScale = 3.0;
		this.Tactical.getWeather().buildCloudCover(clouds);
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendStollwurm);
		
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 170)
		{
			b.MeleeSkill += 10;
			b.DamageTotalMult += 0.1;
		}
		
		b.IsAffectedByNight = false;
		b.IsImmuneToKnockBackAndGrab = true;
		b.IsImmuneToStun = true;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToRoot = true;
		b.IsImmuneToZoneOfControl = false;
		b.IsIgnoringArmorOnAttack = true;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.MoraleCheckBraveryMult[this.Const.MoraleCheckType.MentalAttack] *= 10000.0;
		b.IsMovable = false;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		
		this.addSprite("socket").setBrush("bust_base_dryad");
		local legs_back = this.addSprite("legs_back");
		legs_back.setBrush("");
		local body = this.addSprite("body");
		body.setBrush("bust_druid_lindy_3");
		local legs_front = this.addSprite("legs_front");
		legs_front.setBrush("bust_druid_lindy_2");
		legs_front.Color = body.Color;
		legs_front.Saturation = body.Saturation;
		legs_back.Color = body.Color;
		legs_back.Saturation = body.Saturation;
		local head = this.addSprite("head");
		head.setBrush("bust_druid_lindy");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		local body_blood = this.addSprite("body_blood");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.63;
		this.setSpriteOffset("status_rooted", this.createVec(0, 15));
		this.setSpriteOffset("status_stunned", this.createVec(-5, 30));
		this.setSpriteOffset("arrow", this.createVec(-5, 30));
		
		this.m.Skills.add(this.new("scripts/skills/racial/lindwurm_racial"));
		
		this.m.Skills.add(this.new("scripts/skills/traits/loyal_trait"));
		
		this.m.Skills.add(this.new("scripts/skills/actives/gorge_skill"));
		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		
		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_muscularity"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Hitpoints = b.Hitpoints * 1.5;
			this.m.ActionPoints = b.ActionPoints + 5;
		}

		if (::Is_MC_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nggh_lindwurm_acid"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nggh_lindwurm_body"));
		}
		
		if (!this.Tactical.State.isScenarioMode())
		{
			local dateToSkip = 0;

			switch(this.World.Assets.getCombatDifficulty())
			{
			case this.Const.Difficulty.Easy:
				dateToSkip = 250;
				break;

			case this.Const.Difficulty.Normal:
				dateToSkip = 200;
				break;

			case this.Const.Difficulty.Hard:
				dateToSkip = 150;
				break;

			case this.Const.Difficulty.Legendary:
				dateToSkip = 100;
				break;
			}

			if (this.World.getTime().Days >= dateToSkip)
			{
				local bonus = this.Math.min(1, this.Math.floor((this.World.getTime().Days - dateToSkip) / 20.0));
				b.MeleeSkill += bonus;
				b.RangedSkill += bonus;
				b.MeleeDefense += this.Math.floor(bonus / 2);
				b.RangedDefense += this.Math.floor(bonus / 2);
				b.Hitpoints += this.Math.floor(bonus * 2);
				b.Initiative += this.Math.floor(bonus / 2);
				b.Stamina += bonus;
				b.Bravery += bonus;
				b.FatigueRecoveryRate += this.Math.floor(bonus / 4);
			}
		}

		if (this.m.Tail == null)
		{
			local myTile = this.getTile();
			local spawnTile;

			if (myTile.hasNextTile(this.Const.Direction.NE) && myTile.getNextTile(this.Const.Direction.NE).IsEmpty)
			{
				spawnTile = myTile.getNextTile(this.Const.Direction.NE);
			}
			else if (myTile.hasNextTile(this.Const.Direction.SE) && myTile.getNextTile(this.Const.Direction.SE).IsEmpty)
			{
				spawnTile = myTile.getNextTile(this.Const.Direction.SE);
			}
			else if (myTile.hasNextTile(this.Const.Direction.N) && myTile.getNextTile(this.Const.Direction.N).IsEmpty)
			{
				spawnTile = myTile.getNextTile(this.Const.Direction.N);
			}
			else if (myTile.hasNextTile(this.Const.Direction.S) && myTile.getNextTile(this.Const.Direction.S).IsEmpty)
			{
				spawnTile = myTile.getNextTile(this.Const.Direction.S);
			}
			else if (myTile.hasNextTile(this.Const.Direction.NW) && myTile.getNextTile(this.Const.Direction.NW).IsEmpty)
			{
				spawnTile = myTile.getNextTile(this.Const.Direction.NW);
			}
			else if (myTile.hasNextTile(this.Const.Direction.SW) && myTile.getNextTile(this.Const.Direction.SW).IsEmpty)
			{
				spawnTile = myTile.getNextTile(this.Const.Direction.SW);
			}

			if (spawnTile != null)
			{
				this.m.Tail = this.WeakTableRef(this.Tactical.spawnEntity("scripts/entity/tactical/enemies/dryad_lindy_tail", spawnTile.Coords.X, spawnTile.Coords.Y, this.getID()));
				this.m.Tail.m.Body = this.WeakTableRef(this);
				this.m.Tail.getSprite("body").Color = body.Color;
				this.m.Tail.getSprite("body").Saturation = body.Saturation;
			}
		}
	}
	
	function onMovementFinish( _tile )
	{
		this.actor.onMovementFinish(_tile);

		if (this.m.Tail != null && !this.m.Tail.isNull() && this.m.Tail.isAlive())
			this.Tactical.TurnSequenceBar.moveEntityToFront(this.m.Tail.getID());
	}
});
