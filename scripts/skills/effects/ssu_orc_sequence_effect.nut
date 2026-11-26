this.ssu_orc_sequence_effect <- this.inherit("scripts/skills/effects/ssu_sequence_effect", {
	m = {
		SkillCount = 0,
		Rage = 0
	},
	function create()
	{
		this.ssu_sequence_effect.create();
		this.setSequence("orc");
		this.m.Icon = "skills/status_effect_127.png";
		this.m.Overlay = "status_effect_127";
		this.m.StrongIcon = "skills/status_effect_130.png";
	}

	function onAdded()
	{
		this.refreshOrcWeapons();
	}

	function onStrainAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getSkills().removeByID("trait.tiny");
		::Mod_Sellswords.addSequenceSkill(actor, "trait.huge", "scripts/skills/traits/huge_trait");
		::Mod_Sellswords.addSequencePerk(actor, ::Legends.Perk.Colossus, 0);
		this.refreshOrcWeapons();
	}

	// orc weapons only drop their extra Fatigue cost when they are equipped by someone already proficient with them
	function refreshOrcWeapons()
	{
		if (!this.isStrong())
			return;

		local actor = this.getContainer().getActor();
		actor.getCurrentProperties().IsProficientWithHeavyWeapons = true;

		foreach (slot in [this.Const.ItemSlot.Mainhand, this.Const.ItemSlot.Offhand])
		{
			local item = actor.getItems().getItemAtSlot(slot);

			if (item != null)
			{
				actor.getItems().unequip(item);
				actor.getItems().equip(item);
			}
		}
	}

	function onUpdate( _properties )
	{
		_properties.IsResistantToPhysicalStatuses = true;
		_properties.DamageTotalMult *= this.isStrong() ? 1.2 : 1.1;
		_properties.Hitpoints += this.isStrong() ? 20 : 10;

		if (!this.isStrong())
			return;

		_properties.IsProficientWithHeavyWeapons = true;
		_properties.Stamina += 10;

		// Hyperactive Glands
		_properties.DamageReceivedTotalMult *= this.Math.maxf(0.3, 1.0 - 0.02 * this.m.Rage);
		_properties.Bravery += this.m.Rage;
		_properties.DamageRegularMin += this.m.Rage;
		_properties.DamageRegularMax += this.m.Rage;
		_properties.Initiative += this.m.Rage;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		// once per skill that hits
		if (!this.isStrong() || this.m.SkillCount == this.Const.SkillCounter)
			return;

		this.m.SkillCount = this.Const.SkillCounter;
		local actor = this.getContainer().getActor();

		if (_attacker == null || _attacker.getID() == actor.getID() || _damageHitpoints <= 0)
			return;

		this.m.Rage = this.Math.min(this.m.Rage + 3, 15);

		if (!actor.isHiddenToPlayer())
		{
			this.spawnIcon("status_effect_143", actor.getTile());
			this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_sequence_effect.LogRage, this.Const.UI.getColorizedEntityName(actor)));
		}
	}

	function onTurnEnd()
	{
		this.m.Rage = this.Math.max(0, this.m.Rage - 1);
	}

	function onCombatStarted()
	{
		this.m.SkillCount = 0;
		this.m.Rage = 0;
	}

	function onCombatFinished()
	{
		this.m.SkillCount = 0;
		this.m.Rage = 0;
	}

});
