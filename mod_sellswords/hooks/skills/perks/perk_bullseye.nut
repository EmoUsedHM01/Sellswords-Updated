::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_bullseye", function ( q ) {

	q.onUpdate = @( __original ) function ( _properties )
	{
		_properties.RangedAttackBlockedChanceMult *= 0.44;

		// checked here and not only once in onAdded, a bow brings its own Mark Target and takes it along when it is unequipped
		if (!this.getContainer().hasActive(::Legends.Active.LegendMarkTarget))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendMarkTarget);
		}
	}

	q.onRemoved = @( __original ) function ()
	{
		__original();
		local skill = ::Legends.Actives.get(this, ::Legends.Active.LegendMarkTarget);

		// the one a bow brought stays
		if (skill != null && ::MSU.isNull(skill.getItem()))
		{
			this.getContainer().remove(skill);
		}
	}

	q.onAnySkillUsed =  @() function(_skill, _targetEntity, _properties)
	{
		if (_skill.isAttack() && _targetEntity != null && _targetEntity.getID() != this.getContainer().getActor().getID() && _targetEntity.getFaction() == this.getContainer().getActor().getFaction())
		{
			_properties.MeleeSkillMult *= 0.5;
			_properties.RangedSkillMult *= 0.5;
		}
	}

});