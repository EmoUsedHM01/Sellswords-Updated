::mods_hookExactClass("skills/perks/perk_legend_unarmed_training", function ( o )
{
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		local actor = this.getContainer().getActor();

		if (_skill.getID() == "actives.hand_to_hand" || _skill.getID() == "actives.legend_unarmed_lunge")
		{
			if (!_properties.IsSpecializedInFists)
			{
				_properties.DamageArmorMult *= 1.2;
			}	
			if (this.getContainer().hasSkill("perk.sundering_strikes"))
			{
				_properties.DamageArmorMult *= 1.2;					
			} 
			
			local damage = (actor.getInitiative() + actor.getHitpoints()) / 25;
			
			if (actor.getOffhandItem() != null)
			{
				damage = damage * 0.5;
			}
			
			if (actor.getMainhandItem() != null)
			{
				damage = damage * 0.2;
			}				

			if (this.getContainer().hasSkill("perk.crGrandslam"))
			{
				damage = damage * 1.5;
				_properties.DamageDirectMult = 1.5;					
			}

			_properties.DamageRegularMin += 0.9 * damage;
            _properties.DamageRegularMax += damage;
		}

		if (_skill.getID() == "actives.legend_choke")
		{
			_properties.DamageTotalMult *= 1.5;
			_properties.MeleeSkill += 10;
		}
	};
});