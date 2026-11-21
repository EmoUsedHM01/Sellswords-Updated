this.ssu_schrat_sequence_effect <- this.inherit("scripts/skills/effects/ssu_sequence_effect", {
	m = {},
	function create()
	{
		this.ssu_sequence_effect.create();
		this.setSequence("schrat");
		this.m.Icon = "skills/status_effect_146.png";
		this.m.Overlay = "status_effect_146";
	}

	function onStrainAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getSkills().removeByID("trait.dumb");
		::Mod_Sellswords.addSequenceSkill(actor, "trait.bright", "scripts/skills/traits/bright_trait");
	}

	function onUpdate( _properties )
	{
		_properties.IsImmuneToKnockBackAndGrab = true;

		if (this.isStrong())
			this.keepSkill("actives.grow_shield", "scripts/skills/actives/grow_shield_skill");
	}

	// Wooden Carapace
	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill == null)
			return;

		if (_hitInfo.DamageType == this.Const.Damage.DamageType.Burning)
		{
			_properties.DamageReceivedRegularMult *= 2.0;
			return;
		}

		if (_hitInfo.DamageType != this.Const.Damage.DamageType.Piercing || !_skill.isRanged())
			return;

		local weapon = _skill.getItem();
		local isBow = weapon != null && weapon.isItemType(this.Const.Items.ItemType.Weapon) && (weapon.isWeaponType(this.Const.Items.WeaponType.Bow) || weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow));
		_properties.DamageReceivedRegularMult *= isBow ? 0.25 : 0.5;
	}

	// Symbiotic Seeds of the Greenwood Strain
	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		local actor = this.getContainer().getActor();

		if (!this.isStrong() || _damageHitpoints < actor.getHitpointsMax() * 0.15)
			return;

		local myTile = actor.getTile();
		local candidates = [];

		for (local i = 0; i < 6; i++)
		{
			if (!myTile.hasNextTile(i))
				continue;

			local tile = myTile.getNextTile(i);

			if (tile.IsEmpty && this.Math.abs(myTile.Level - tile.Level) <= 1)
				candidates.push(tile);
		}

		if (candidates.len() == 0)
			return;

		local tile = candidates[this.Math.rand(0, candidates.len() - 1)];
		local sapling = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/schrat_small", tile.Coords);
		sapling.setFaction(actor.getFaction() == this.Const.Faction.Player ? this.Const.Faction.PlayerAnimals : actor.getFaction());
		sapling.riseFromGround();
	}

});
