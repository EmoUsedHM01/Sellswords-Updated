this.flaming_arrows_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TargetTile = null,
		DamageMin = 10,
		DamageMax = 20
	},
	function create()
	{
		this.m.ID = "effects.flaming_arrows";
		this.m.Name = " ";
		this.m.Description = " ";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}
	
	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts an additional fire damage based on 50% weapon damage, ignites ground beneath the target"
			}
		]);
		return ret;
	}
	
	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		this.m.TargetTile = _targetEntity.getTile();
		local mainhand = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		this.m.DamageMin = this.Math.round(mainhand.getDamageMin() * 0.5);
		this.m.DamageMax = this.Math.round(mainhand.getDamageMax() * 0.5);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.m.TargetTile != null)
		{
			this.Time.scheduleEvent(this.TimeUnit.Real, 50, this.onApply.bindenv(_skill), {
				Skill = _skill,
				User = this.getContainer().getActor(),
				TargetTile = this.m.TargetTile,
				DamageMin = this.m.DamageMin,
				DamageMax = this.m.DamageMax
			});
		}
		this.m.TargetTile = null;
	}

	function onApply( _data )
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (item.isWeaponType(::Const.Items.WeaponType.Bow))
		{
			local targets = [];
			targets.push(_data.TargetTile);

			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], 1.0, _data.TargetTile.Pos);
			local p = {
				Type = "fire",
				Tooltip = "Fire rages here, melting armor and flesh alike",
				IsPositive = false,
				IsAppliedAtRoundStart = false,
				IsAppliedAtTurnEnd = true,
				IsAppliedOnMovement = false,
				IsAppliedOnEnter = false,
				IsByPlayer = _data.User.isPlayerControlled(),
				Timeout = this.Time.getRound() + 2,
				Callback = this.Const.Tactical.Common.onApplyFire,
				function Applicable( _a )
				{
					return true;
				}
			};

			foreach( tile in targets )
			{
				if (tile.Subtype != this.Const.Tactical.TerrainSubtype.Snow && tile.Subtype != this.Const.Tactical.TerrainSubtype.LightSnow && tile.Type != this.Const.Tactical.TerrainType.ShallowWater && tile.Type != this.Const.Tactical.TerrainType.DeepWater)
				{
					if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "fire")
					{
						tile.Properties.Effect.Timeout = this.Time.getRound() + 2;
					}
					else
					{
						if (tile.Properties.Effect != null)
						{
							this.Tactical.Entities.removeTileEffect(tile);
						}

						tile.Properties.Effect = clone p;
						local particles = [];

						for( local i = 0; i < this.Const.Tactical.FireParticles.len(); i = ++i )
						{
							particles.push(this.Tactical.spawnParticleEffect(true, this.Const.Tactical.FireParticles[i].Brushes, tile, this.Const.Tactical.FireParticles[i].Delay, this.Const.Tactical.FireParticles[i].Quantity, this.Const.Tactical.FireParticles[i].LifeTimeQuantity, this.Const.Tactical.FireParticles[i].SpawnRate, this.Const.Tactical.FireParticles[i].Stages));
						}

						this.Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);
						tile.clear(this.Const.Tactical.DetailFlag.Scorchmark);
						tile.spawnDetail("impact_decal", this.Const.Tactical.DetailFlag.Scorchmark, false, true);
					}
				}

				if (tile.IsOccupiedByActor)
				{
					local entity = tile.getEntity();
					
					if (entity.getCurrentProperties().IsImmuneToFire)
					{
						return;
					}
			
					this.Tactical.spawnIconEffect("status_effect_116", tile, this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
					local sounds = [
						"sounds/combat/dlc6/status_on_fire_01.wav",
						"sounds/combat/dlc6/status_on_fire_02.wav",
						"sounds/combat/dlc6/status_on_fire_03.wav"
					];
					this.Sound.play(sounds[this.Math.rand(0, sounds.len() - 1)], this.Const.Sound.Volume.Actor, entity.getPos());
					local damageMult = 1.0;
			
					if (entity.getSkills().hasSkill("racial.schrat") || entity.getSkills().hasSkill("racial.legend_greenwood_schrat"))
					{
						damageMult = 5.0;
					}
			
					if (entity.getSkills().hasSkill("racial.skeleton") || entity.getSkills().hasSkill("racial.vampire"))
					{
						damageMult = 2.0;
					}
			
					if (entity.getSkills().hasSkill("items.firearms_resistance") || entity.getSkills().hasSkill("racial.serpent"))
					{
						damageMult = 0.66;
					}
			
					local damage = this.Math.rand(_data.DamageMin, _data.DamageMax);
					local hitInfo = clone this.Const.Tactical.HitInfo;
					hitInfo.DamageRegular = damage * damageMult;
					hitInfo.DamageArmor = damage;
					hitInfo.DamageDirect = 0.5;
					hitInfo.BodyPart = this.Const.BodyPart.Body;
					hitInfo.BodyDamageMult = 1.0;
					hitInfo.FatalityChanceMult = 0.0;
					hitInfo.Injuries = this.Const.Injury.Burning;
					hitInfo.IsPlayingArmorSound = false;
					entity.onDamageReceived(entity, null, hitInfo);		

				}
			}
		}
		if (item.isWeaponType(::Const.Items.WeaponType.Crossbow))
		{
			local targets = [];
			targets.push(_data.TargetTile);

			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], 1.0, _data.TargetTile.Pos);
			local p = {
				Type = "fire",
				Tooltip = "Fire rages here, melting armor and flesh alike",
				IsPositive = false,
				IsAppliedAtRoundStart = false,
				IsAppliedAtTurnEnd = true,
				IsAppliedOnMovement = false,
				IsAppliedOnEnter = false,
				IsByPlayer = _data.User.isPlayerControlled(),
				Timeout = this.Time.getRound() + 2,
				Callback = this.Const.Tactical.Common.onApplyFire,
				function Applicable( _a )
				{
					return true;
				}
			};

			foreach( tile in targets )
			{
				if (tile.Subtype != this.Const.Tactical.TerrainSubtype.Snow && tile.Subtype != this.Const.Tactical.TerrainSubtype.LightSnow && tile.Type != this.Const.Tactical.TerrainType.ShallowWater && tile.Type != this.Const.Tactical.TerrainType.DeepWater)
				{
					if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "fire")
					{
						tile.Properties.Effect.Timeout = this.Time.getRound() + 2;
					}
					else
					{
						if (tile.Properties.Effect != null)
						{
							this.Tactical.Entities.removeTileEffect(tile);
						}

						tile.Properties.Effect = clone p;
						local particles = [];

						for( local i = 0; i < this.Const.Tactical.FireParticles.len(); i = ++i )
						{
							particles.push(this.Tactical.spawnParticleEffect(true, this.Const.Tactical.FireParticles[i].Brushes, tile, this.Const.Tactical.FireParticles[i].Delay, this.Const.Tactical.FireParticles[i].Quantity, this.Const.Tactical.FireParticles[i].LifeTimeQuantity, this.Const.Tactical.FireParticles[i].SpawnRate, this.Const.Tactical.FireParticles[i].Stages));
						}

						this.Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);
						tile.clear(this.Const.Tactical.DetailFlag.Scorchmark);
						tile.spawnDetail("impact_decal", this.Const.Tactical.DetailFlag.Scorchmark, false, true);
					}
				}

				if (tile.IsOccupiedByActor)
				{
					local entity = tile.getEntity();
					
					if (entity.getCurrentProperties().IsImmuneToFire)
					{
						return;
					}
			
					this.Tactical.spawnIconEffect("status_effect_116", tile, this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
					local sounds = [
						"sounds/combat/dlc6/status_on_fire_01.wav",
						"sounds/combat/dlc6/status_on_fire_02.wav",
						"sounds/combat/dlc6/status_on_fire_03.wav"
					];
					this.Sound.play(sounds[this.Math.rand(0, sounds.len() - 1)], this.Const.Sound.Volume.Actor, entity.getPos());
					local damageMult = 1.0;
			
					if (entity.getSkills().hasSkill("racial.schrat") || entity.getSkills().hasSkill("racial.legend_greenwood_schrat"))
					{
						damageMult = 5.0;
					}
			
					if (entity.getSkills().hasSkill("racial.skeleton") || entity.getSkills().hasSkill("racial.vampire"))
					{
						damageMult = 2.0;
					}
			
					if (entity.getSkills().hasSkill("items.firearms_resistance") || entity.getSkills().hasSkill("racial.serpent"))
					{
						damageMult = 0.66;
					}
			
					local damage = this.Math.rand(_data.DamageMin, _data.DamageMax);
					local hitInfo = clone this.Const.Tactical.HitInfo;
					hitInfo.DamageRegular = damage * damageMult;
					hitInfo.DamageArmor = damage;
					hitInfo.DamageDirect = 0.5;
					hitInfo.BodyPart = this.Const.BodyPart.Body;
					hitInfo.BodyDamageMult = 1.0;
					hitInfo.FatalityChanceMult = 0.0;
					hitInfo.Injuries = this.Const.Injury.Burning;
					hitInfo.IsPlayingArmorSound = false;
					entity.onDamageReceived(entity, null, hitInfo);		
					
				}
			}
		}
	}
});

