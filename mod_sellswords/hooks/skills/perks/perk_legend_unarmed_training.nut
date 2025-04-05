::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_unarmed_training", function ( q ) {

	q.onAnySkillUsed = @( __original) function ( _skill, _targetEntity, _properties )
	{
		local actor = this.getContainer().getActor();

		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.HandToHand) || _skill.getID() == ::Legends.Actives.getID(::Legends.Active.LegendUnarmedLunge))
		{
			if (_properties.IsSpecializedInFists)
				_properties.DamageArmorMult *= 1.2;
			if (::Legends.Actives.has(this, ::Legends.Perk.SunderingStrikes))
				_properties.DamageArmorMult *= 1.2;

			local damage = (actor.getInitiative() + actor.getHitpoints()) / 25;

			if (actor.getOffhandItem() != null)
				damage = damage * 0.5;

			if (actor.getMainhandItem() != null)
				damage = damage * 0.2;

			if (this.getContainer().hasSkill("perk.crGrandslam"))
			{
				damage = damage * 1.5;
			}

			_properties.DamageRegularMin += this.Math.floor(0.9 * damage);
			_properties.DamageRegularMax += this.Math.floor(damage);
		}

		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.LegendChoke))
		{
			_properties.DamageTotalMult *= 1.5;
			_properties.MeleeSkill += 10;
		}
	}

});