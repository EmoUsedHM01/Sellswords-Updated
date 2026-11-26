// Flag marks a character as having the Sequence, StrongFlag as having its stronger Strain.
// The effect of a Sequence is scripts/skills/effects/ssu_<key>_sequence_effect, its texts are ::Mod_Sellswords.Strings.ssu_<key>_sequence_effect
::Mod_Sellswords.Sequences <- {
	alp = {
		Flag = "alp",
		StrongFlag = "alp_d"
	},
	basilisk = {
		Flag = "basilisk",
		StrongFlag = "basilisk_s"
	},
	direwolf = {
		Flag = "direwolf",
		StrongFlag = "direwolf_w"
	},
	ghoul = {
		Flag = "ghoul",
		StrongFlag = "ghoul_s"
	},
	goblin = {
		Flag = "goblin",
		StrongFlag = null
	},
	hyena = {
		Flag = "hyena",
		StrongFlag = "hyena_e"
	},
	orc = {
		Flag = "orc",
		StrongFlag = "orc_w"
	},
	schrat = {
		Flag = "schrat",
		StrongFlag = "schrat_g"
	},
	serpent = {
		Flag = "serpent",
		StrongFlag = null
	},
	spider = {
		Flag = "spider",
		StrongFlag = "spider_r"
	},
	unhold = {
		Flag = "unhold",
		StrongFlag = "unhold_r"
	},
	vampire = {
		Flag = "vampire",
		StrongFlag = "vampire_l"
	},
	wurm = {
		Flag = "wurm",
		StrongFlag = "wurm_s"
	}
};

// gives _actor the Sequence, or its stronger Strain. The stronger Strain always comes with everything of the weaker one
::Mod_Sellswords.addSequence <- function (_actor, _sequence, _isStrong) {

	local def = ::Mod_Sellswords.Sequences[_sequence];
	_actor.getFlags().add(def.Flag);

	if (_isStrong && def.StrongFlag != null)
		_actor.getFlags().add(def.StrongFlag);

	local effect = _actor.getSkills().getSkillByID("effects.ssu_" + _sequence + "_sequence");

	if (effect == null)
	{
		effect = ::new("scripts/skills/effects/ssu_" + _sequence + "_sequence_effect");
		_actor.getSkills().add(effect);
	}

	effect.onStrainAdded();
	_actor.getSkills().update();
};

// adds the skill at _script unless the character already has the one with _id
::Mod_Sellswords.addSequenceSkill <- function (_actor, _id, _script) {

	if (!_actor.getSkills().hasSkill(_id))
		_actor.getSkills().add(::new(_script));
};

// perks of a Sequence are free. Brothers also get them shown in their perk tree
// a brother who already bought the perk gets the perk point back, the perk is then marked as not refundable so this happens only once
::Mod_Sellswords.addSequencePerk <- function (_actor, _perk, _row) {

	if (typeof _actor == "instance")
		_actor = _actor.get();

	local id = ::Legends.Perks.getID(_perk);

	if (_actor.getSkills().hasSkill(id))
	{
		if (!::isKindOf(_actor, "player"))
			return;

		local tree = _actor.getBackground().m.PerkTreeMap;

		if (id in tree && tree[id].IsRefundable)
		{
			_actor.m.PerkPoints += 1;
			_actor.m.PerkPointsSpent -= 1;
			tree[id].IsRefundable = false;
		}

		return;
	}

	if (::isKindOf(_actor, "player"))
		_actor.getBackground().addPerk(_perk, _row, false);

	::Legends.Perks.grant(_actor, _perk);
};

::Mod_Sellswords.checkSequence <- function (_actor, _flag) {

	local time = 0.0;
	if (("State" in this.World) && this.World.State != null && this.World.State.getCombatStartTime() != 0)
		time = this.World.State.getCombatStartTime();
	else
		time = this.Time.getVirtualTimeF();

	_actor.getFlags().increment("PotionsUsed", 1);
	_actor.getFlags().set("PotionLastUsed", time);
	
	//if upgrading a sequence
	if (_actor.getFlags().has(_flag))
		return;

	local num_mutations = _actor.getFlags().getAsInt("ActiveMutations");

	if (num_mutations == 0)
	{
		_actor.getFlags().increment("ActiveMutations");
		return;
	}

	_actor.getFlags().increment("ActiveMutations");
	
	if (this.World.Assets.getOrigin().getID() == "scenario.anatomists")
		if (_actor.getFlags().getAsInt("ActiveMutations") <= 2)
			return;

	if (_actor.getSkills().getSkillByID("perk.hold_out"))
		if (_actor.getFlags().getAsInt("ActiveMutations") <= 2)
			return;

	if (_actor.getFlags().getAsInt("ActiveMutations") >= 2)
	{
		_actor.getItems().transferToStash(this.World.Assets.getStash());
		_actor.getSkills().onDeath(this.Const.FatalityType.None);
		::Legends.addFallen(_actor, "Their mutations went out of control.");
		this.World.getPlayerRoster().remove(_actor);
	}
};

::Mod_Sellswords.doPotionDrop <- function (_killer, _skill, _tile, _fatalityType, chance, item) {

	if ((_tile != null && (_killer == null || ::Mod_Sellswords.AllLootDrops)) || (_killer != null && _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals))
	{
		local count = 0.0;
		local roster = ::World.getPlayerRoster().getAll();
		foreach( i, bro in roster )
		{
			if (i >= 25)
				break;

			if (bro.getBackground().getID() == "background.anatomist")
				count++;
		}

		if (::World.Assets.getOrigin().getID() == "scenario.anatomists")
			count *= 2;
		
		local rand = this.Math.rand(1.0, 100.0);
		this.logInfo("Rolling for potion: " + rand + " vs " + chance * count);

		if (rand <= chance * count)
		{
			local loot = this.new(item);
			loot.drop(_tile);
		}
	}
};

::Mod_Sellswords.doHostileSequencePotionDrop <- function(_killer, _skill, _tile, _fatalityType, _actor) {
	local drops = [
		["serpent", 5, "serpent"],
		["direwolf", 5, "direwolf"],
		["ghoul", 2.5, "nachzehrer"],
		["spider", 2.5, "webknecht"],
		["unhold", 5, "unhold"],
		["vampire", 5, "necro_necrosavant"],
		["goblin", 2.5, "goblin"],
		["orc", 2.5, "orc"],
		["basilisk", 2.5, "basilisk"],
		["hyena", 2.5, "hyena"]
	];

	foreach (drop in drops)
	{
		if (!_actor.getFlags().has(drop[0]))
			continue;

		::Mod_Sellswords.doPotionDrop(_killer, _skill, _tile, _fatalityType, drop[1], "scripts/items/misc/anatomist/ssu_" + drop[2] + "_sequence_item");
		return;
	}
}

// Sequences of hostile humans. Besides the Sequence itself they get a few perks in place of what a brother would have picked
::Mod_Sellswords.add_serpent <- function (_actor, complete) {

	::Mod_Sellswords.addSequence(_actor, "serpent", false);
};

::Mod_Sellswords.add_direwolf <- function (_actor, complete) {

	::Mod_Sellswords.addSequence(_actor, "direwolf", complete);
	_actor.getSkills().add(this.new("scripts/skills/effects/alp_potion_effect"));

	if (complete)
	{
		_actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_battleheart"));
		_actor.getSkills().add(this.new("scripts/skills/perks/perk_pathfinder"));
	}
};

::Mod_Sellswords.add_ghoul <- function (_actor, complete) {

	::Mod_Sellswords.addSequence(_actor, "ghoul", complete);
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_alert"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_killing_frenzy"));
};

::Mod_Sellswords.add_spider <- function (_actor, complete) {

	::Mod_Sellswords.addSequence(_actor, "spider", complete);

	if (complete)
		_actor.getSkills().add(this.new("scripts/skills/perks/perk_nimble"));
};

::Mod_Sellswords.add_unhold <- function (_actor, complete) {

	::Mod_Sellswords.addSequence(_actor, "unhold", complete);
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_colossus"));
};

::Mod_Sellswords.add_orc <- function (_actor, complete) {

	::Mod_Sellswords.addSequence(_actor, "orc", complete);
};

::Mod_Sellswords.add_necrosavant <- function (_actor, complete) {

	::Mod_Sellswords.addSequence(_actor, "vampire", complete);

	if (complete)
		_actor.getSkills().add(this.new("scripts/skills/actives/darkflight"));
};

::Mod_Sellswords.add_goblin <- function (_actor, complete) {

	::Mod_Sellswords.addSequence(_actor, "goblin", false);
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_footwork"));
};

::Mod_Sellswords.add_basilisk <- function (_actor, complete) {

	::Mod_Sellswords.addSequence(_actor, "basilisk", complete);
};

::Mod_Sellswords.add_hyena <- function (_actor, complete) {

	::Mod_Sellswords.addSequence(_actor, "hyena", complete);
};
