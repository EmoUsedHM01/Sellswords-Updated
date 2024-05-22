// Hooking each background individually and adding their unique perks through a function
// I ran into a lot of issues getting this up and running, so hopefully my comments provide sufficient enough context so that people can use the code in the future with a better understanding of BB modhooks

::mods_hookExactClass("skills/backgrounds/adventurous_noble_background", function(o) {

	// The "local ws_onAdded = " makes sure we're adding to the hook instead of overwriting it, the o.character_background.onAdded; means that for backgrounds that don't have a pre-existing onAdded function, we're making a new one and then making it compatible with other mods that want to fuck with it
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		// The "ws_onAdded();" is what makes sure we're adding to the hook
		ws_onAdded();
		// This is what gives us the perk to the bro. Note; this only adds the perk to the bro, and not to their perk map
		this.m.Container.add(this.new("scripts/skills/perks/perk_rotation"));
	}	
	
	// The "local buildPerkTree = o.character_background.buildPerkTree;" needs to be added because this file spawns the perk before the "buildPerkTree" function from Legends loads, resulting in it adding to something that doesn't exist
	// You could use "local buildPerkTree = ::mods_getMember(o, "buildPerkTree");" instead but there is an edge case with named Shamshir's which results in all values being overridden, for full context see https://discord.com/channels/965324395851694140/1052648104815513670 in the BB modding discord
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
		// This is where we actually add the perk to the buildPerkTree that Legends creates. Having this means that not only will you gain the perk from the onAdded function, but it will also appear in the perk map for the bro 
        this.addPerk(::Const.Perks.PerkDefs.Rotation, 0, false)
		this.addPerk(::Const.Perks.PerkDefs.crFurinkazan, 1, false)
    }
});

::mods_hookExactClass("skills/backgrounds/anatomist_background", function(o) {

	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_debilitate"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Debilitate, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/apprentice_background", function(o) {

	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_student"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Student, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/assassin_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_opportunist"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendOpportunist, 0, false)
    }
});

	// Hashassin
::mods_hookExactClass("skills/backgrounds/assassin_southern_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_opportunist"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendOpportunist, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/barbarian_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_berserk"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Berserk, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/bastard_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_underdog"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Underdog, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/beast_hunter_background", function(o) {

	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_net_repair"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendNetRepair, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/beggar_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_underdog"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Underdog, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/belly_dancer_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_twirl"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendTwirl, 0, false)
		this.addPerk(::Const.Perks.PerkDefs.crFurinkazan, 1, false)
    }
});

::mods_hookExactClass("skills/backgrounds/bowyer_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_specialist_shortbow_skill"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendSpecialistShortbowSkill, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/brawler_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_grapple"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendGrapple, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/butcher_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_specialist_butcher_skill"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendSpecialistButcherSkill, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/caravan_hand_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_efficient_packing"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendEfficientPacking, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/companion_1h_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_feint"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Feint, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/companion_2h_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_bloody_harvest"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.BloodyHarvest, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/companion_ranged_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_bullseye"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Bullseye, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/cripple_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_meek"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendMeek, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/crusader_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_favoured_enemy_zombie"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendFavouredEnemyZombie, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/cultist_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_specialist_cult_hood"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendSpecCultHood, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/daytaler_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_colossus"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Colossus, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/deserter_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_back_to_basics"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendBackToBasics, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/disowned_noble_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendAssuredConquest, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/eunuch_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_helpful"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendHelpful, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/farmhand_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_specialist_pitchfork_skill"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendSpecialistPitchforkSkill, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/female_adventurous_noble_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_bullseye"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Bullseye, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/female_disowned_noble_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_rotation"));
	}
	
	local buildPerkTree = o.character_background.buildPerkTree;
	o.buildPerkTree <- function()
	{
		buildPerkTree();
		this.addPerk(::Const.Perks.PerkDefs.Rotation, 0, false)
		this.addPerk(::Const.Perks.PerkDefs.crFurinkazan, 1, false)
	}
});

::mods_hookExactClass("skills/backgrounds/fisherman_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_net_casting"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendNetCasting, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/flagellant_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_specialist_ninetails_skill"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendSpecialistNinetailsSkill, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/gambler_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_barter_greed"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendBarterGreed, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/gladiator_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_battle_flow"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.BattleFlow, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/gravedigger_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_specialist_shovel_skill"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendSpecialistShovelSkill, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/graverobber_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_specialist_shovel_skill"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendSpecialistShovelSkill, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/hedge_knight_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_steel_brow"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.SteelBrow, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/historian_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_scholar"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendScholar, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/houndmaster_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_dogwhisperer"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendDogWhisperer, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/hunter_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_ballistics"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Ballistics, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/juggler_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_hair_splitter"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendHairSplitter, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/killer_on_the_run_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_backstabber"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Backstabber, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/legend_alchemist_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_potion_brewer"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendPotionBrewer, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_assassin_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_opportunist"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendOpportunist, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/legend_assassin_commander_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_opportunist"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendOpportunist, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/legend_beggar_commander_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_meek"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendMeek, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_beggar_commander_op_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_meek"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendMeek, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_berserker_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_adrenalin"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Adrenaline, 0, false)
		this.addPerk(::Const.Perks.PerkDefs.crirresistibleimpulse, 1, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_berserker_commander_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_adrenalin"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Adrenaline, 0, false)
		this.addPerk(::Const.Perks.PerkDefs.crirresistibleimpulse, 1, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_blacksmith_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_specialist_hammer_skill"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendSpecialistHammerSkill, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_bounty_hunter_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_dodge"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Dodge, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_cannibal_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_camp_cook"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendCampCook, 0, false)
    }
});
	
	//Lonewolf event bro
::mods_hookExactClass("skills/backgrounds/legend_companion_melee_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_brawny"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Brawny, 0, false)
    }	
});
	
	//Lonewolf event bro
::mods_hookExactClass("skills/backgrounds/legend_companion_ranged_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_ballistics"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Ballistics, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_conscript_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_dodge"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Dodge, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_crusader_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_favoured_enemy_zombie"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendFavouredEnemyZombie, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_crusader_commander_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_favoured_enemy_vampire"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendFavouredEnemyVampire, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_dervish_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_battle_flow"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.BattleFlow, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_donkey_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_pacifist"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendPacifist, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_druid_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_herbcraft"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendHerbcraft, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_druid_commander_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_herbcraft"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendHerbcraft, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_guildmaster_background", function(o) {

	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_net_repair"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendNetRepair, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_healer_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_mastery_bandage"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendSpecBandage, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/legend_herbalist_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_herbcraft"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendHerbcraft, 0, false)
    }	
});
	
    // Cultist stuff
::mods_hookExactClass("skills/backgrounds/legend_husk_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_specialist_cult_hood"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendSpecCultHood, 0, false)
    }
});
	
    // Cultist stuff
::mods_hookExactClass("skills/backgrounds/legend_lurker_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_specialist_cult_hood"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendSpecCultHood, 0, false)
    }
});
	
    // Cultist stuff
::mods_hookExactClass("skills/backgrounds/legend_magister_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_specialist_cult_armor"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendSpecCultArmor, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_inventor_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/legend_inventor_anatomy"));
	}
});
	
::mods_hookExactClass("skills/backgrounds/legend_ironmonger_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_tools_spares"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendToolsSpares, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_leech_peddler_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_med_ingredients"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendMedIngredients, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_lonewolf_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_lone_wolf"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LoneWolf, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/legend_man_at_arms_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_crGuardian"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.crGuardian, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_master_archer_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_ballistics"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Ballistics, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_muladi_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_dogwhisperer"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendDogWhisperer, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_nightwatch_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_night_raider"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendNightRaider, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_noble_2h", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_forceful_swing"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendForcefulSwing, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/legend_noble_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendAssuredConquest, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/legend_noble_commander_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendAssuredConquest, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/legend_noble_ranged", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_crParthianshot"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.crParthianshot, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_noble_shield", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_shield_expert"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.ShieldExpert, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_peddler_commander_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_barter_trustworthy"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendBarterTrustworthy, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/legend_pilgrim_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_prayer_of_faith"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendPrayerOfFaith, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/legend_qiyan_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_barter_convincing"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendBarterConvincing, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/legend_ranger_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_ammo_binding"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendAmmoBinding, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/legend_ranger_commander_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_ammo_binding"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendAmmoBinding, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/legend_shieldmaiden_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_crGuardian"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.crGuardian, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/legend_taxidermist_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_bags_and_belts"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.BagsAndBelts, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/legend_trader_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/legends/off_book_deal"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendOffBookDeal, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/legend_trader_commander_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/legends/off_book_deal"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendOffBookDeal, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/legend_vala_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/legend_vala_warden"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendValaWarden, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/legend_vala_commander_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/legend_vala_warden"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendValaWarden, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/legend_youngblood_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_favoured_enemy_hexen"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendFavouredEnemyHexen, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/lindwurm_slayer_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_favoured_enemy_lindwurm"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendFavouredEnemyLindwurm, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/lumberjack_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_specialist_woodaxe_skill"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendSpecialistWoodaxeSkill, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/manhunter_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_dodge"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Dodge, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/mason_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_crPerseverance"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.crPerseverance, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/messenger_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_lookout"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Lookout, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/militia_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_specialist_militia_skill"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendSpecialistMilitiaSkill, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/miller_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_camp_cook"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendCampCook, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/miner_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_specialist_pickaxe_skill"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendSpecialistPickaxeSkill, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/minstrel_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_drums_of_war"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendDrumsOfWar, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/monk_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_holyflame"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendHolyFlame, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/legend_nun_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_holyflame"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendHolyFlame, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/nomad_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_throw_sand"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendThrowSand, 0, false)
    }
});

	// Greenskin Invasion Ranger
::mods_hookExactClass("skills/backgrounds/orc_slayer_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_favoured_enemy_ork"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendFavouredEnemyOrk, 0, false)
    }
});

    // Oathtaker
::mods_hookExactClass("skills/backgrounds/paladin_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_battle_forged"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.BattleForged, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/peddler_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_barter_convincing"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendBarterConvincing, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/pimp_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_barter_convincing"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendBarterConvincing, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/poacher_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_lookout"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Lookout, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/raider_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_bloodbath"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendBloodbath, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/ratcatcher_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_net_repair"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendNetRepair, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/refugee_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_underdog"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Underdog, 0, false)
    }	
});
	
::mods_hookExactClass("skills/backgrounds/regent_in_absentia_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_rotation"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Rotation, 0, false)
		this.addPerk(::Const.Perks.PerkDefs.crFurinkazan, 1, false)
    }
});

::mods_hookExactClass("skills/backgrounds/retired_soldier_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_back_to_basics"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendBackToBasics, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/sellsword_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_specialist_shield_skill"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendSpecialistShieldSkill, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/servant_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_meal_preperation"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendMealPreperation, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/shepherd_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_specialist_sling_skill"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendSpecialistSlingSkill, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/slave_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_recuperation"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendRecuperation, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/squire_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_perfect_fit"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendPerfectFit, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/swordmaster_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_duelist"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Duelist, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/tailor_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_tools_drawers"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendToolsDrawers, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/thief_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_dodge"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.Dodge, 0, false)
    }	
});

::mods_hookExactClass("skills/backgrounds/vagabond_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_fast_adaption"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.FastAdaption, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/wildman_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_gatherer"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendGatherer, 0, false)
    }
});
	
::mods_hookExactClass("skills/backgrounds/wildwoman_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_gatherer"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendGatherer, 0, false)
    }
});

::mods_hookExactClass("skills/backgrounds/witchhunter_background", function(o) {
	
	local ws_onAdded = o.character_background.onAdded;
	o.onAdded <- function()
	{
		ws_onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_favoured_enemy_hexen"));
	}	
	
	local buildPerkTree = o.character_background.buildPerkTree;
    o.buildPerkTree <- function()
    {
        buildPerkTree();
        this.addPerk(::Const.Perks.PerkDefs.LegendFavouredEnemyHexen, 0, false)
    }
});