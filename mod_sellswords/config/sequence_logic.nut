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

	if (_actor.getSkills().getSkillByID("perk.crresilient"))
		if (_actor.getFlags().getAsInt("ActiveMutations") <= 2)
			return;

	if (_actor.getFlags().getAsInt("ActiveMutations") >= 2)
	{
		_actor.getItems().transferToStash(this.World.Assets.getStash());
		_actor.getSkills().onDeath(this.Const.FatalityType.None);
		this.World.Statistics.addFallen(_actor, "Their mutations went out of control.");
		this.World.getPlayerRoster().remove(_actor);
	}
};

::Mod_Sellswords.doPotionDrop <- function (_killer, _skill, _tile, _fatalityType, chance, item) {

	if ((_tile != null && _killer == null) || (_killer != null && _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals))
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
	local actorFlags = _actor.getFlags();
	local chance = 0;
	local item = null;
	switch (true)
	{
		case actorFlags.has("serpent"):
			chance = 5;
			item = "scripts/items/misc/anatomist/serpent_sequence_item";
		case actorFlags.has("werewolf"):
			chance = 5;
			item = "scripts/items/misc/anatomist/direwolf_sequence_item";
		case actorFlags.has("ghoul"):
			chance = 2.5;
			item = "scripts/items/misc/anatomist/nachzehrer_sequence_item";
		case actorFlags.has("spider"):
			chance = 2.5;
			item = "scripts/items/misc/anatomist/webknecht_sequence_item";
		case actorFlags.has("unhold"):
			chance = 5;
			item = "scripts/items/misc/anatomist/unhold_sequence_item";
		case actorFlags.has("vampire"):
			chance = 5;
			item = "scripts/items/misc/anatomist/necrosavant_sequence_item";
		case actorFlags.has("goblin"):
			chance = 2.5;
			item = "scripts/items/misc/anatomist/goblin_sequence_item";
		case actorFlags.has("orc"):
			chance = 2.5;
			item = "scripts/items/misc/anatomist/orc_sequence_item";
	}
	if (item != null)
	{
		::Mod_Sellswords.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
	}
}

::Mod_Sellswords.add_serpent <- function (_actor, complete) {

	_actor.getFlags().add("serpent");
	_actor.getSkills().add(this.new("scripts/skills/effects/serpent_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/effects/webknecht_potion_effect"));
};

::Mod_Sellswords.add_direwolf <- function (_actor, complete) {

	_actor.getFlags().add("werewolf");
	_actor.getSkills().add(this.new("scripts/skills/racial/direwolf_player_racial"));
	_actor.getSkills().add(this.new("scripts/skills/effects/direwolf_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/effects/alp_potion_effect"));

	if (complete)
	{
		_actor.getFlags().add("werewolf_w");
		_actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_battleheart"));
		_actor.getSkills().add(this.new("scripts/skills/perks/perk_pathfinder"));
	}
};

::Mod_Sellswords.add_ghoul <- function (_actor, complete) {

	_actor.getFlags().add("ghoul");
	_actor.getSkills().add(this.new("scripts/skills/effects/nachzehrer_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_gruesome_feast"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_alert"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_killing_frenzy"));

	if (complete)
	{
		_actor.getFlags().add("ghoul_s");
		_actor.getSkills().add(this.new("scripts/skills/effects/unhold_potion_effect"));
		_actor.getSkills().add(this.new("scripts/skills/effects/hyena_potion_effect"));
		_actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_lacerate"));
	}
};

::Mod_Sellswords.add_spider <- function (_actor, complete) {

	_actor.getFlags().add("spider");
	_actor.getSkills().add(this.new("scripts/skills/effects/serpent_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/effects/webknecht_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/effects/alp_potion_effect"));

	if (complete)
	{
		_actor.getFlags().add("spider_r");
		_actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_item_web_skill"));
		_actor.getSkills().add(this.new("scripts/skills/perks/perk_nimble"));
	}
};

::Mod_Sellswords.add_unhold <- function (_actor, complete) {

	_actor.getFlags().add("unhold");
	_actor.getSkills().add(this.new("scripts/skills/effects/unhold_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/effects/wiederganger_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_colossus"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_muscularity"));

	if (complete)
	{
		_actor.getFlags().add("unhold_r");
		_actor.getSkills().add(this.new("scripts/skills/effects/orc_warrior_potion_effect"));
	}
};

::Mod_Sellswords.add_orc <- function (_actor, complete) {

	_actor.getFlags().add("orc");
	_actor.getSkills().add(this.new("scripts/skills/effects/orc_young_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/effects/orc_warrior_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_colossus"));

	if (complete)
	{
		_actor.getFlags().add("orc_w");
		_actor.getSkills().add(this.new("scripts/skills/effects/orc_warlord_potion_effect"));
		_actor.getSkills().add(this.new("scripts/skills/effects/orc_berserker_potion_effect"));
	}
};

::Mod_Sellswords.add_necrosavant <- function (_actor, complete) {

	_actor.getFlags().add("vampire");
	_actor.getSkills().add(this.new("scripts/skills/effects/necrosavant_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_nine_lives"));

	if (complete)
	{
		_actor.getFlags().add("vampire_l");
		_actor.getSkills().add(this.new("scripts/skills/effects/ancient_priest_potion_effect"));
		_actor.getSkills().add(this.new("scripts/skills/actives/darkflight"));
		_actor.getSkills().add(this.new("scripts/skills/effects/webknecht_potion_effect"));
	}
};

::Mod_Sellswords.add_goblin <- function (_actor, complete) {

	_actor.getFlags().add("goblin");
	_actor.getSkills().add(this.new("scripts/skills/effects/goblin_overseer_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/effects/goblin_grunt_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_footwork"));
};