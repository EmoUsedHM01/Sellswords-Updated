::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/throw_dirt_skill", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "Throws dirt or sand to distract the enemy. Reduces inititive and damage output of the target by 35% for one turn. Wild Nomad used sand-attack!";
		this.m.Icon = "skills/active_215.png";
		this.m.IconDisabled = "skills/active_215_sw.png";
		this.m.IsUsingHitchance = false;
	};
	
	q.getTooltip <- function()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Throws dirt or sand at the face of the target, temporarily blinding them"
			}
		];
		return ret;
	};
	
	q.isUsable = @( __original ) function()
	{
		return this.skill.isUsable();
	};
	
	q.onUse = @( __original ) function( _user, _targetTile )
	{
		if (_targetTile.getEntity().isAlliedWithPlayer())
		{
			local effect = {
				Delay = 0,
				Quantity = 20,
				LifeTimeQuantity = 20,
				SpawnRate = 400,
				Brushes = [
					"sand_dust_01"
				],
				Stages = [
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.2,
						ColorMin = ::createColor("eeeeee00"),
						ColorMax = ::createColor("ffffff00"),
						ScaleMin = 0.5,
						ScaleMax = 0.5,
						RotationMin = 0,
						RotationMax = 359,
						VelocityMin = 60,
						VelocityMax = 100,
						DirectionMin = ::createVec(-0.7, -0.6),
						DirectionMax = ::createVec(-0.6, -0.6),
						SpawnOffsetMin = ::createVec(-35, -15),
						SpawnOffsetMax = ::createVec(35, 20)
					},
					{
						LifeTimeMin = 0.75,
						LifeTimeMax = 1.0,
						ColorMin = ::createColor("eeeeeeee"),
						ColorMax = ::createColor("ffffffff"),
						ScaleMin = 0.5,
						ScaleMax = 0.75,
						VelocityMin = 60,
						VelocityMax = 100,
						ForceMin = ::createVec(0, 0),
						ForceMax = ::createVec(0, 0)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.2,
						ColorMin = ::createColor("eeeeee00"),
						ColorMax = ::createColor("ffffff00"),
						ScaleMin = 0.75,
						ScaleMax = 1.0,
						VelocityMin = 0,
						VelocityMax = 0,
						ForceMin = ::createVec(0, -100),
						ForceMax = ::createVec(0, -100)
					}
				]
			};
			this.Tactical.spawnParticleEffect(false, effect.Brushes, _targetTile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(30, 70));
		}
		else
		{
			local effect = {
				Delay = 0,
				Quantity = 20,
				LifeTimeQuantity = 20,
				SpawnRate = 400,
				Brushes = [
					"sand_dust_01"
				],
				Stages = [
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.2,
						ColorMin = ::createColor("eeeeee00"),
						ColorMax = ::createColor("ffffff00"),
						ScaleMin = 0.5,
						ScaleMax = 0.5,
						RotationMin = 0,
						RotationMax = 359,
						VelocityMin = 60,
						VelocityMax = 100,
						DirectionMin = ::createVec(0.6, -0.6),
						DirectionMax = ::createVec(0.7, -0.6),
						SpawnOffsetMin = ::createVec(-35, -15),
						SpawnOffsetMax = ::createVec(35, 20)
					},
					{
						LifeTimeMin = 1.0,
						LifeTimeMax = 1.25,
						ColorMin = ::createColor("eeeeeeee"),
						ColorMax = ::createColor("ffffffff"),
						ScaleMin = 0.5,
						ScaleMax = 0.75,
						VelocityMin = 60,
						VelocityMax = 100,
						ForceMin = ::createVec(0, 0),
						ForceMax = ::createVec(0, 0)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.2,
						ColorMin = ::createColor("eeeeee00"),
						ColorMax = ::createColor("ffffff00"),
						ScaleMin = 0.75,
						ScaleMax = 1.0,
						VelocityMin = 0,
						VelocityMax = 0,
						ForceMin = ::createVec(0, -100),
						ForceMax = ::createVec(0, -100)
					}
				]
			};
			this.Tactical.spawnParticleEffect(false, effect.Brushes, _targetTile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, ::createVec(-30, 70));
		}

		_targetTile.getEntity().getSkills().add(::new("scripts/skills/effects/distracted_effect"));
		this.Tactical.getShaker().shake(_targetTile.getEntity(), _user.getTile(), 4);

		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " throws dirt in " + this.Const.UI.getColorizedEntityName(_targetTile.getEntity()) + "\'s face to distract them");
		}

		return true;
	};
});
