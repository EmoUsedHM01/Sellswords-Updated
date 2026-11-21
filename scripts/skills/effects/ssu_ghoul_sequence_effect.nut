this.ssu_ghoul_sequence_effect <- this.inherit("scripts/skills/effects/ssu_sequence_effect", {
	m = {},
	function create()
	{
		this.ssu_sequence_effect.create();
		this.setSequence("ghoul");
		this.m.Icon = "skills/status_effect_149.png";
		this.m.Overlay = "status_effect_149";
	}

	function onStrainAdded()
	{
		local actor = this.getContainer().getActor();
		::Mod_Sellswords.addSequencePerk(actor, ::Legends.Perk.LegendGruesomeFeast, 0);

		if (this.isStrong())
			::Mod_Sellswords.addSequencePerk(actor, ::Legends.Perk.LegendLacerate, 6);
	}

	function onUpdate( _properties )
	{
		_properties.AdditionalHealingDays -= 1;
		_properties.Initiative += this.isStrong() ? 20 : 10;

		if (this.isStrong())
			_properties.Hitpoints += 10;
	}

	// Subdermal Clotting
	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (this.isStrong() && _skill != null && _skill.getID() == "effects.bleeding")
			_properties.DamageReceivedRegularMult *= 0.5;
	}

	function onTurnStart()
	{
		if (this.isStrong() && !this.isPoisoned())
			this.regenerate(10);
	}

	function onCombatFinished()
	{
		if (this.isStrong())
			this.healFully();
	}

});
