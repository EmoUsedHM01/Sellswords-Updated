this.ssu_wurm_sequence_effect <- this.inherit("scripts/skills/effects/ssu_sequence_effect", {
	m = {},
	function create()
	{
		this.ssu_sequence_effect.create();
		this.setSequence("wurm");
		this.m.Icon = "skills/status_effect_140.png";
		this.m.Overlay = "status_effect_140";
		this.m.StrongIcon = "skills/ssu_effect_stoll.png";
	}

	// Descendant of Dragons
	function onStrainAdded()
	{
		local actor = this.getContainer().getActor();

		foreach (trait in ["short_sighted", "fat", "bleeder", "ailing", "fragile", "asthmatic", "clubfooted", "night_blind", "legend_frail", "clumsy"])
			actor.getSkills().removeByID("trait." + trait);

		foreach (trait in ["eagle_eyes", "tough", "strong", "quick", "dexterous", "iron_lungs", "athletic", "iron_jaw"])
			::Mod_Sellswords.addSequenceSkill(actor, "trait." + trait, "scripts/skills/traits/" + trait + "_trait");
	}

	function onUpdate( _properties )
	{
		_properties.Hitpoints += this.isStrong() ? 50 : 15;
		_properties.DamageTotalMult *= this.isStrong() ? 1.3 : 1.15;

		if (this.isStrong())
		{
			_properties.IsResistantToPhysicalStatuses = true;
			_properties.FatigueLossOnAnyAttackMult = 0.0;
		}
	}

	// Caustic Blood
	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		local actor = this.getContainer().getActor();

		if (_damageHitpoints <= 0 || _attacker == null || !_attacker.isAlive() || _attacker.getID() == actor.getID())
			return;

		if (_attacker.getTile().getDistanceTo(actor.getTile()) > 1 || _attacker.getFlags().has("lindwurm"))
			return;

		local isBodyImmune = _attacker.getFlags().has("body_immune_to_acid") || _attacker.getArmor(this.Const.BodyPart.Body) <= 0;
		local isHeadImmune = _attacker.getFlags().has("head_immune_to_acid") || _attacker.getArmor(this.Const.BodyPart.Head) <= 0;

		if (isBodyImmune && isHeadImmune)
			return;

		local acid = _attacker.getSkills().getSkillByID("effects.lindwurm_acid");

		if (acid == null)
			_attacker.getSkills().add(this.new("scripts/skills/effects/lindwurm_acid_effect"));
		else
			acid.resetTime();

		this.spawnIcon("status_effect_78", _attacker.getTile());
	}

});
