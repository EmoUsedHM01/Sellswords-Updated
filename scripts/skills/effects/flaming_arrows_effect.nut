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
				text = "Inflicts additional fire damage based on 50% weapon damage, ignites ground beneath the target"
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

		if (!(item.isWeaponType(::Const.Items.WeaponType.Bow) || item.isWeaponType(::Const.Items.WeaponType.Crossbow)))
			return;

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

		foreach( tile in targets ) // Apply the fire to the tiles
		{
			if (tile.Subtype != this.Const.Tactical.TerrainSubtype.Snow && tile.Subtype != this.Const.Tactical.TerrainSubtype.LightSnow && tile.Type != this.Const.Tactical.TerrainType.ShallowWater && tile.Type != this.Const.Tactical.TerrainType.DeepWater)
			{
				if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "fire")
					tile.Properties.Effect.Timeout = this.Time.getRound() + 2;
				else
				{
					if (tile.Properties.Effect != null)
						this.Tactical.Entities.removeTileEffect(tile);

					tile.Properties.Effect = clone p;
					local particles = [];

					for( local i = 0; i < this.Const.Tactical.FireParticles.len(); i = ++i )
						particles.push(this.Tactical.spawnParticleEffect(true, this.Const.Tactical.FireParticles[i].Brushes, tile, this.Const.Tactical.FireParticles[i].Delay, this.Const.Tactical.FireParticles[i].Quantity, this.Const.Tactical.FireParticles[i].LifeTimeQuantity, this.Const.Tactical.FireParticles[i].SpawnRate, this.Const.Tactical.FireParticles[i].Stages));

					this.Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);
					tile.clear(this.Const.Tactical.DetailFlag.Scorchmark);
					tile.spawnDetail("impact_decal", this.Const.Tactical.DetailFlag.Scorchmark, false, true);
				}
			}

			if (tile.IsOccupiedByActor) // Apply the damage
				::Const.Tactical.Common.onApplyFire(tile, tile.getEntity());
		}
	}

});