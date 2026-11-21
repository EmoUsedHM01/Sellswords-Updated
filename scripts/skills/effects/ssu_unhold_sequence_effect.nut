this.ssu_unhold_sequence_effect <- this.inherit("scripts/skills/effects/ssu_sequence_effect", {
	m = {},
	function create()
	{
		this.ssu_sequence_effect.create();
		this.setSequence("unhold");
		this.m.Icon = "skills/status_effect_145.png";
		this.m.Overlay = "status_effect_145";
	}

	function onStrainAdded()
	{
		::Mod_Sellswords.addSequencePerk(this.getContainer().getActor(), ::Legends.Perk.LegendMuscularity, 4);
	}

	function onUpdate( _properties )
	{
		_properties.ThresholdToReceiveInjuryMult *= 1.33;
		_properties.Hitpoints += this.isStrong() ? 20 : 10;

		if (this.isStrong())
			_properties.IsResistantToPhysicalStatuses = true;
	}

	function onTurnStart()
	{
		if (this.isPoisoned())
			return;

		this.regenerate(this.isStrong() ? 10 : 5);

		if (this.isStrong())
			this.repairArmor(20);
	}

	function onCombatFinished()
	{
		this.healFully();

		if (this.isStrong())
			this.repairArmor(9999);
	}

	// Thick Skinned of the Mountain Strain
	function repairArmor( _armor )
	{
		local actor = this.getContainer().getActor();

		if (actor == null || actor.isNull() || !actor.isAlive())
			return;

		local logs = {
			[this.Const.ItemSlot.Head] = ::Mod_Sellswords.Strings.ssu_sequence_effect.LogHeadArmor,
			[this.Const.ItemSlot.Body] = ::Mod_Sellswords.Strings.ssu_sequence_effect.LogBodyArmor
		};

		foreach (slot, log in logs)
		{
			local item = actor.getItems().getItemAtSlot(slot);
			local repaired = item == null ? 0 : this.Math.min(item.getArmorMax() - item.getArmor(), _armor);

			if (repaired <= 0)
				continue;

			item.setArmor(item.getArmor() + repaired);
			actor.setDirty(true);

			if (actor.isPlacedOnMap() && !actor.isHiddenToPlayer())
				this.Tactical.EventLog.log(::Mod_Sellswords.text(log, this.Const.UI.getColorizedEntityName(actor), repaired));
		}
	}

});
