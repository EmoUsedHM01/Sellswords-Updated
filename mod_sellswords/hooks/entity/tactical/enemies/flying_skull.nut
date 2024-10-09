::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/enemies/flying_skull", function( q ) {

	q.onActorKilled = @(__original) function(_actor, _tile, _skill)
	{
		this.actor.onActorKilled(_actor, _tile, _skill);

		if (this.getFaction() == ::Const.Faction.Player || this.getFaction() == ::Const.Faction.PlayerAnimals)
		{
			local XPgroup = _actor.getXPValue();
			local brothers = ::Tactical.Entities.getInstancesOfFaction(::Const.Faction.Player);

			foreach(bro in brothers)
				bro.addXP(::Math.max(1, ::Math.floor(XPgroup / brothers.len())));
		}
	}
	
	q.addMoreHP <- function( _master )
	{
		this.m.BaseProperties.Hitpoints += _master.getBravery();
		this.m.Skills.update();
		this.setHitpointsPct(1.0);
	}
	
	q.onExplode <- function()
	{
		local myTile = this.getTile();
		local skill = this.getSkills().getSkillByID("actives.explode");
		local max_dam = this.Math.floor(this.getHitpointsMax() * 0.8);
		local min_dam = this.Math.floor(max_dam * 0.5);

		if (skill != null)
		{
			skill.m.InjuriesOnBody = ::Const.Injury.PiercingBody;
			skill.m.InjuriesOnHead = ::Const.Injury.PiercingHead;
			skill.m.ChanceDisembowel = 50;
			skill.m.IsUsingHitchance = false;
		}

		for( local i = 0; i < 6; i = ++i )
		{
			if (!myTile.hasNextTile(i))
			{
			}
			else
			{
				local nextTile = myTile.getNextTile(i);

				if (::Math.abs(myTile.Level - nextTile.Level) <= 1 && nextTile.IsOccupiedByActor)
				{
					local target = nextTile.getEntity();

					if (!target.isAlive() || target.isDying() || this.actor.isAlliedWith(target))
					{
					}
					else
					{
						local hitInfo = clone ::Const.Tactical.HitInfo;
						hitInfo.DamageRegular = ::Math.rand(min_dam, max_dam);
						hitInfo.DamageArmor = hitInfo.DamageRegular * 0.75;
						hitInfo.DamageDirect = 0.3;
						hitInfo.BodyPart = ::Const.BodyPart.Body;
						hitInfo.FatalityChanceMult = 1.0;
						hitInfo.Injuries = ::Const.Injury.PiercingBody;
						target.onDamageReceived(this, skill, hitInfo);
					}
				}
			}
		}
	}
	
	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		local myTile = this.getTile();

		if (!this.m.IsExploded)
		{
			this.m.IsExploded = true;
			local effect = {
				Delay = 0,
				Quantity = 80,
				LifeTimeQuantity = 80,
				SpawnRate = 400,
				Brushes = [
					"blood_splatter_bones_01",
					"blood_splatter_bones_03",
					"blood_splatter_bones_04",
					"blood_splatter_bones_05",
					"blood_splatter_bones_06"
				],
				Stages = [
					{
						LifeTimeMin = 1.0,
						LifeTimeMax = 1.0,
						ColorMin = ::createColor("ffffffff"),
						ColorMax = ::createColor("ffffffff"),
						ScaleMin = 1.0,
						ScaleMax = 1.5,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 200,
						VelocityMax = 300,
						DirectionMin = ::createVec(-1.0, -1.0),
						DirectionMax = ::createVec(1.0, 1.0),
						SpawnOffsetMin = ::createVec(0, 0),
						SpawnOffsetMax = ::createVec(0, 0),
						ForceMin = ::createVec(0, 0),
						ForceMax = ::createVec(0, 0)
					},
					{
						LifeTimeMin = 0.75,
						LifeTimeMax = 1.0,
						ColorMin = ::createColor("ffffff8f"),
						ColorMax = ::createColor("ffffff8f"),
						ScaleMin = 0.9,
						ScaleMax = 0.9,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 200,
						VelocityMax = 300,
						DirectionMin = ::createVec(-1.0, -1.0),
						DirectionMax = ::createVec(1.0, 1.0),
						ForceMin = ::createVec(0, -100),
						ForceMax = ::createVec(0, -100)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.1,
						ColorMin = ::createColor("ffffff00"),
						ColorMax = ::createColor("ffffff00"),
						ScaleMin = 0.1,
						ScaleMax = 0.1,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 200,
						VelocityMax = 300,
						DirectionMin = ::createVec(-1.0, -1.0),
						DirectionMax = ::createVec(1.0, 1.0),
						ForceMin = ::createVec(0, -100),
						ForceMax = ::createVec(0, -100)
					}
				]
			};
			::Tactical.spawnParticleEffect(false, effect.Brushes, myTile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, ::createVec(0, 50));
			this.onExplode();
			::Sound.play(::MSU.Array.rand(this.m.Sound[::Const.Sound.ActorEvent.Other1]), ::Const.Sound.Volume.Actor, this.getPos());
			::Sound.play(::MSU.Array.rand(this.m.Sound[::Const.Sound.ActorEvent.Other2]), ::Const.Sound.Volume.Actor, this.getPos());
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}
	
	q.onInit = @(__original) function()
	{
		__original();
		this.m.Skills.add(::new("scripts/skills/racial/skeleton_racial"));
		this.Tactical.queryTilesInRange(this.actor.getTile(), 1, 6, false, [], this.onQueryTile, this.actor.getFaction());
	}

	q.onQueryTile <- function( _tile, _tag )
	{
		if (this.Const.Faction.PlayerAnimals)
			_tile.addVisibilityForFaction(this.Const.Faction.Player);

		if (_tile.IsOccupiedByActor)
			_tile.getEntity().setDiscovered(true);
	}

})