::mods_hookExactClass("skills/actives/slash_lightning", function ( o )
{
	o.getTooltip = function ()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts an additional [color=" + this.Const.UI.Color.DamageValue + "]15%[/color] damage that ignores armor to up to three targets"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.HitChanceBonus + "%[/color] chance to hit"
			}
		]);
		return ret;
	};
	o.applyEffect = function ( _data, _delay )
	{
		this.Time.scheduleEvent(this.TimeUnit.Virtual, _delay, function ( _data )
		{
			for( local i = 0; i < this.Const.Tactical.LightningParticles.len(); i = i )
			{
				this.Tactical.spawnParticleEffect(true, this.Const.Tactical.LightningParticles[i].Brushes, _data.TargetTile, this.Const.Tactical.LightningParticles[i].Delay, this.Const.Tactical.LightningParticles[i].Quantity, this.Const.Tactical.LightningParticles[i].LifeTimeQuantity, this.Const.Tactical.LightningParticles[i].SpawnRate, this.Const.Tactical.LightningParticles[i].Stages);
				i = ++i;
			}
		}, _data);

		if (_data.Target == null)
		{
			return;
		}

		this.Time.scheduleEvent(this.TimeUnit.Virtual, _delay + 200, function ( _data )
		{
			local p = _data.User.getCurrentProperties();
			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = 0.15 * this.Math.rand(p.DamageRegularMin, p.DamageRegularMax) * p.DamageRegularMult * p.MeleeDamageMult * p.DamageTotalMult;
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			_data.Target.onDamageReceived(_data.User, _data.Skill, hitInfo);
		}, _data);
	};
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += 10;
			_skill.resetField("HitChanceBonus");
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
			{
				_properties.MeleeSkill += 5;
				this.m.HitChanceBonus += 5;
			}
		}
	};
	o.onUse = function ( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSlash);
		local success = this.attackEntity(_user, _targetTile.getEntity());
		local myTile = _user.getTile();
		if (success && _user.isAlive() && this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == _user.getID())
		{
			local selectedTargets = [];
			local potentialTargets = [];
			local potentialTiles = [];
			local target;
			local targetTile = _targetTile;
			if (this.m.SoundOnLightning.len() != 0)
			{
				this.Sound.play(this.m.SoundOnLightning[this.Math.rand(0, this.m.SoundOnLightning.len() - 1)], this.Const.Sound.Volume.Skill * 2.0, _user.getPos());
			}
			if (!targetTile.IsEmpty && targetTile.getEntity().isAlive())
			{
				target = targetTile.getEntity();
				selectedTargets.push(target.getID());
			}
			local data = {
				Skill = this,
				User = _user,
				TargetTile = targetTile,
				Target = target
			};
			this.applyEffect(data, 100);
			potentialTargets = [];
			potentialTiles = [];
			for( local i = 0; i < 6; i = ++i )
			{
				if (!targetTile.hasNextTile(i))
				{
				}
				else
				{
					local tile = targetTile.getNextTile(i);

					if (tile.ID != myTile.ID)
					{
						potentialTiles.push(tile);
					}

					if (!tile.IsOccupiedByActor || !tile.getEntity().isAttackable() || tile.getEntity().isAlliedWith(_user) || selectedTargets.find(tile.getEntity().getID()) != null)
					{
					}
					else
					{
						potentialTargets.push(tile);
					}
				}
			}
			if (potentialTargets.len() != 0)
			{
				target = potentialTargets[this.Math.rand(0, potentialTargets.len() - 1)].getEntity();
				selectedTargets.push(target.getID());
				targetTile = target.getTile();
			}
			else
			{
				target = null;
				targetTile = potentialTiles[this.Math.rand(0, potentialTiles.len() - 1)];
			}
			local data = {
				Skill = this,
				User = _user,
				TargetTile = targetTile,
				Target = target
			};
			this.applyEffect(data, 350);
			potentialTargets = [];
			potentialTiles = [];
			for( local i = 0; i < 6; i = ++i )
			{
				if (!targetTile.hasNextTile(i))
				{
				}
				else
				{
					local tile = targetTile.getNextTile(i);

					if (tile.ID != myTile.ID)
					{
						potentialTiles.push(tile);
					}

					if (!tile.IsOccupiedByActor || !tile.getEntity().isAttackable() || tile.getEntity().isAlliedWith(_user) || selectedTargets.find(tile.getEntity().getID()) != null)
					{
					}
					else
					{
						potentialTargets.push(tile);
					}
				}
			}
			if (potentialTargets.len() != 0)
			{
				target = potentialTargets[this.Math.rand(0, potentialTargets.len() - 1)].getEntity();
				selectedTargets.push(target.getID());
				targetTile = target.getTile();
			}
			else
			{
				target = null;
				targetTile = potentialTiles[this.Math.rand(0, potentialTiles.len() - 1)];
			}

			local data = {
				Skill = this,
				User = _user,
				TargetTile = targetTile,
				Target = target
			};
			this.applyEffect(data, 550);
		}
		return success;
	}		
});