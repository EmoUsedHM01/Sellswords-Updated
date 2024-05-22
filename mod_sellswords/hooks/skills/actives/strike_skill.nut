::mods_hookExactClass("skills/actives/strike_skill", function(o) {
	o.m.ApplyBonusToBodyPart <- -1;

	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]2" + "[/color] tiles"
		});

		if (this.m.ApplyAxeMastery)
		{
			if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms)
			{
				ret.push({
					id = 6,
					type = "text",
					icon = "ui/icons/hitchance.png",
					text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] chance to hit targets directly adjacent"
				});
			}
			if (this.getContainer().hasSkill("perk.crHackSPM"))
			{
				ret.extend([
					{
						id = 6,
						type = "text",
						icon = "ui/icons/special.png",
						text = "Do a free extra attack with [color=" + this.Const.UI.Color.PositiveValue + "]25%[/color] damage(not regarded as critical strikes) on a hit"
					}
				]);	
			}			
		}
		else
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] chance to hit"
			});

			if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms)
			{
				ret.push({
					id = 6,
					type = "text",
					icon = "ui/icons/hitchance.png",
					text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
				});
			}
		}				

		return ret;
	}

	o.onUse = function( _user, _targetTile )
	{
		if (!this.m.ApplyAxeMastery || !this.getContainer().hasSkill("perk.crHackSPM"))
		{
			this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSplitShield);
			return this.attackEntity(_user, _targetTile.getEntity());
		}			
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSplitShield);
		local targetEntity = _targetTile.getEntity();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}
		
		if (success && this.m.ApplyBonusToBodyPart == this.Const.BodyPart.Head && !_targetTile.IsEmpty && targetEntity.isAlive())
		{
			local p = this.getContainer().buildPropertiesForUse(this, targetEntity);
			local hitInfo = clone this.Const.Tactical.HitInfo;
			local damageRegular = this.Math.rand(p.DamageRegularMin, p.DamageRegularMax) * p.DamageRegularMult * 0.25 * p.MeleeDamageMult * p.DamageTotalMult;
			local damageArmor = this.Math.rand(p.DamageRegularMin, p.DamageRegularMax) * p.DamageArmorMult * 0.25;
			local damageDirect = this.Math.minf(1.0, p.DamageDirectMult * (this.m.DirectDamageMult + p.DamageDirectAdd + p.DamageDirectMeleeAdd));
			hitInfo.DamageRegular = damageRegular;
			hitInfo.DamageArmor = damageArmor;
			hitInfo.DamageDirect = damageDirect;
			hitInfo.BodyPart = this.m.ApplyBonusToBodyPart;
			hitInfo.BodyDamageMult = 1.0;
			targetEntity.onDamageReceived(this.getContainer().getActor(), this, hitInfo);
			this.m.ApplyBonusToBodyPart = -1;
		}

		return success;
	}

	o.onTargetHit <- function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this)
		{
			//this.m.ApplyBonusToBodyPart = _bodyPart;
			this.m.ApplyBonusToBodyPart = _bodyPart == this.Const.BodyPart.Body ? this.Const.BodyPart.Head : this.Const.BodyPart.Body;			
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			if (!this.m.ApplyAxeMastery)
			{
				_properties.MeleeSkill += 5;
			}

			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -10;
			}
			else
			{
				this.m.HitChanceBonus = this.m.ApplyAxeMastery ? 0 : 5;
			}			
		}
	}

})