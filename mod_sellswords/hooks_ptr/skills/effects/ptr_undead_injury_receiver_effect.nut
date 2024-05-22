::mods_hookExactClass("skills/effects/ptr_undead_injury_receiver_effect", function ( o )
{
	o.m.AffectedByInjuries <- true;		
	o.onBeforeDamageReceived = function ( _attacker, _skill, _hitInfo, _properties )
	{
		this.m.ReceiveInjuries = true;
		if (_skill == null || _attacker == null)
		{
			return;
		}
		if (this.getContainer().getActor().getSkills().getSkillByID("effects.cr_consecrated"))
		{
			return;			
		}
		if (_skill.getDamageType().contains(this.Const.Damage.DamageType.Cutting))
		{
			local dismemberment = _attacker.getSkills().getSkillByID("perk.ptr_dismemberment");
			if (dismemberment == null || !dismemberment.isEnabled())
			{
				this.m.ReceiveInjuries = false;
				this.m.AffectedByInjuries = false;				
				return;
			}
		}
		if (_skill.getDamageType().contains(this.Const.Damage.DamageType.Blunt))
		{
			local deepImpact = _attacker.getSkills().getSkillByID("perk.ptr_deep_impact");
			if (deepImpact == null || !deepImpact.isEnabled())
			{
				this.m.ReceiveInjuries = false;
				this.m.AffectedByInjuries = false;							
				return;
			}
		}			
		if (_skill.isAttack() && _skill.getDamageType().contains(this.Const.Damage.DamageType.Piercing))
		{
			local fob = _attacker.getSkills().getSkillByID("perk.crFoB");
			if (fob == null)
			{
				this.m.ReceiveInjuries = false;
				this.m.AffectedByInjuries = false;					
				return;
			}
		}
	}
	o.onUpdate = function ( _properties )
	{
		if (this.m.AffectedByInjuries)
		{
			_properties.IsAffectedByInjuries = true;
			_properties.IsAffectedByFreshInjuries = true;					
		}
		else
		{
			_properties.IsAffectedByInjuries = false;
			_properties.IsAffectedByFreshInjuries = false;					
		}			
	}		
});	