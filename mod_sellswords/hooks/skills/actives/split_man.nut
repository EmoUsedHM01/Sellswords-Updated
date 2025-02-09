::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/split_man", function ( q ) {

	q.m.crcriticalbonus <- 0.5;
	q.m.infantry <- 0;
	q.m.orc <- false;

	q.resetcrcriticalbonus <- function()
	{
		this.m.crcriticalbonus = 0.5;
	}

	q.isHidden = @( __original ) function()
	{
		__original();

		local shield = 1;
		if (this.getContainer().hasSkill("actives.shieldwall") || this.getContainer().hasSkill("actives.legend_fortify_skill"))
		{
			shield = 0;
		}
		return this.m.orc == true && shield == 1;
	}	

	q.onUse = @( __original ) function( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local targetEntity = _targetTile.getEntity();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && this.m.ApplyBonusToBodyPart != -1 && !_targetTile.IsEmpty && targetEntity.isAlive())
		{
			if (this.getContainer().hasSkill("perk.crHackSPM"))
			{
				this.m.crcriticalbonus = 1;
			}		
			local p = this.getContainer().buildPropertiesForUse(this, targetEntity);
			local hitInfo = clone this.Const.Tactical.HitInfo;
			local damageRegular = this.Math.rand(p.DamageRegularMin, p.DamageRegularMax) * p.DamageRegularMult * this.m.crcriticalbonus * p.MeleeDamageMult * p.DamageTotalMult;
			local damageArmor = this.Math.rand(p.DamageRegularMin, p.DamageRegularMax) * p.DamageArmorMult * this.m.crcriticalbonus;
			local damageDirect = this.Math.minf(1.0, p.DamageDirectMult * (this.m.DirectDamageMult + p.DamageDirectAdd + p.DamageDirectMeleeAdd));	 //this is a factor between 0 and 1		
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

	q.onAnySkillUsed = @( __original ) function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			__original(_skill, _targetEntity, _properties);
			
			if (this.m.infantry == 1)
			{
				_properties.DamageTotalMult *= 1.2;	
				_properties.HitChanceMult[this.Const.BodyPart.Head] = 0.0;
				_properties.HitChanceMult[this.Const.BodyPart.Body] = 1.0;				
			}					
		}
	}

});
