this.ssu_goblin_sequence_effect <- this.inherit("scripts/skills/effects/ssu_sequence_effect", {
	m = {},
	function create()
	{
		this.ssu_sequence_effect.create();
		this.setSequence("goblin");
		this.m.Icon = "skills/status_effect_124.png";
		this.m.Overlay = "status_effect_124";
	}

	function onStrainAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getSkills().removeByID("trait.huge");
		::Mod_Sellswords.addSequenceSkill(actor, "trait.tiny", "scripts/skills/traits/tiny_trait");
	}

	// the lower costs of Rotation, Footwork, Climb and Evasion are set in the hooks of those skills
	function onUpdate( _properties )
	{
		_properties.IsFleetfooted = true;
		_properties.Initiative += 10;
		_properties.RangedSkill += 10;
		_properties.RangedDefense += 10;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && _skill.isRanged())
			_properties.DamageDirectMult += 0.05;
	}

});
