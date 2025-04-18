// Helper function to setup a background with specific perks
function setupBackground(classPath, perkScripts, perkDefs) 
{
	::Mod_Sellswords.HooksMod.hook(classPath, function( q ) {

		q.onAdded = @(__original) function()
		{
			__original();

			foreach (perkScript in perkScripts)
				this.m.Container.add(this.new(perkScript));
		}	

		q.buildPerkTree = @(__original) function()
		{
			__original();

			foreach (perkDef in perkDefs)
				addPerk(perkDef.def, perkDef.level, perkDef.optional);
		}

	});
}

// Define each background using the helper function
setupBackground("scripts/skills/backgrounds/anatomist_background", ["scripts/skills/perks/perk_legend_debilitate"], [{def = ::Legends.Perk.LegendDebilitate, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/apprentice_background", ["scripts/skills/perks/perk_student"], [{def = ::Legends.Perk.Student, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/assassin_background", ["scripts/skills/perks/perk_legend_opportunist"], [{def = ::Legends.Perk.LegendOpportunist, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/assassin_southern_background", ["scripts/skills/perks/perk_legend_opportunist"], [{def = ::Legends.Perk.LegendOpportunist, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/barbarian_background", ["scripts/skills/perks/perk_berserk"], [{def = ::Legends.Perk.Berserk, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/bastard_background", ["scripts/skills/perks/perk_underdog"], [{def = ::Legends.Perk.Underdog, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/beast_hunter_background", ["scripts/skills/perks/perk_legend_net_repair"], [{def = ::Legends.Perk.LegendNetRepair, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/beggar_background", ["scripts/skills/perks/perk_underdog"], [{def = ::Legends.Perk.Underdog, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/belly_dancer_background", ["scripts/skills/perks/perk_nimble"], [{def = ::Legends.Perk.Nimble, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/bowyer_background", ["scripts/skills/perks/perk_legend_specialist_poacher"], [{def = ::Legends.Perk.LegendSpecialistPoacher, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/brawler_background", ["scripts/skills/perks/perk_legend_grapple"], [{def = ::Legends.Perk.LegendGrapple, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/butcher_background", ["scripts/skills/perks/perk_legend_specialist_butcher"], [{def = ::Legends.Perk.LegendSpecialistButcher, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/caravan_hand_background", ["scripts/skills/perks/perk_legend_efficient_packing"], [{def = ::Legends.Perk.LegendEfficientPacking, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/companion_1h_background", ["scripts/skills/perks/perk_legend_feint"], [{def = ::Legends.Perk.LegendFeint, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/companion_2h_background", ["scripts/skills/perks/perk_legend_bloody_harvest"], [{def = ::Legends.Perk.LegendBloodyHarvest, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/companion_ranged_background", ["scripts/skills/perks/perk_bullseye"], [{def = ::Legends.Perk.Bullseye, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/cripple_background", ["scripts/skills/perks/perk_legend_blend_in"], [{def = ::Legends.Perk.LegendBlendIn, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/crusader_background", ["scripts/skills/perks/perk_legend_favoured_enemy_zombie"], [{def = ::Legends.Perk.LegendFavouredEnemyZombie, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/cultist_background", ["scripts/skills/perks/perk_legend_specialist_cult_hood"], [{def = ::Legends.Perk.LegendSpecCultHood, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/daytaler_background", ["scripts/skills/perks/perk_colossus"], [{def = ::Legends.Perk.Colossus, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/deserter_background", ["scripts/skills/perks/perk_legend_back_to_basics"], [{def = ::Legends.Perk.LegendBackToBasics, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/eunuch_background", ["scripts/skills/perks/perk_legend_helpful"], [{def = ::Legends.Perk.LegendHelpful, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/farmhand_background", ["scripts/skills/perks/perk_legend_specialist_farmhand"], [{def = ::Legends.Perk.LegendSpecialistFarmhand, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/fisherman_background", ["scripts/skills/perks/perk_legend_net_casting"], [{def = ::Legends.Perk.LegendNetCasting, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/flagellant_background", ["scripts/skills/perks/perk_legend_specialist_cultist"], [{def = ::Legends.Perk.LegendSpecialistCultist, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/gambler_background", ["scripts/skills/perks/perk_legend_barter_greed"], [{def = ::Legends.Perk.LegendBarterGreed, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/gladiator_background", ["scripts/skills/perks/perk_battle_flow"], [{def = ::Legends.Perk.BattleFlow, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/gravedigger_background", ["scripts/skills/perks/perk_legend_specialist_gravedigger"], [{def = ::Legends.Perk.LegendSpecialistGravedigger, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/graverobber_background", ["scripts/skills/perks/perk_legend_specialist_gravedigger"], [{def = ::Legends.Perk.LegendSpecialistGravedigger, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/hedge_knight_background", ["scripts/skills/perks/perk_steel_brow"], [{def = ::Legends.Perk.SteelBrow, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/historian_background", ["scripts/skills/perks/perk_legend_scholar"], [{def = ::Legends.Perk.LegendScholar, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/houndmaster_background", ["scripts/skills/perks/perk_legend_dogwhisperer"], [{def = ::Legends.Perk.LegendDogWhisperer, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/hunter_background", ["scripts/skills/perks/perk_legend_ballistics"], [{def = ::Legends.Perk.LegendBallistics, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/juggler_background", ["scripts/skills/perks/perk_legend_hair_splitter"], [{def = ::Legends.Perk.LegendHairSplitter, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/killer_on_the_run_background", ["scripts/skills/perks/perk_backstabber"], [{def = ::Legends.Perk.Backstabber, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_alchemist_background", ["scripts/skills/perks/perk_legend_potion_brewer"], [{def = ::Legends.Perk.LegendPotionBrewer, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_assassin_background", ["scripts/skills/perks/perk_legend_opportunist"], [{def = ::Legends.Perk.LegendOpportunist, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_assassin_commander_background", ["scripts/skills/perks/perk_legend_opportunist"], [{def = ::Legends.Perk.LegendOpportunist, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_beggar_commander_background", ["scripts/skills/perks/perk_legend_blend_in"], [{def = ::Legends.Perk.LegendBlendIn, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_beggar_commander_op_background", ["scripts/skills/perks/perk_legend_blend_in"], [{def = ::Legends.Perk.LegendBlendIn, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_berserker_background", ["scripts/skills/perks/perk_killing_frenzy"], [{def = ::Legends.Perk.KillingFrenzy, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_berserker_commander_background", ["scripts/skills/perks/perk_killing_frenzy"], [{def = ::Legends.Perk.KillingFrenzy, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_blacksmith_background", ["scripts/skills/perks/perk_legend_specialist_blacksmith"], [{def = ::Legends.Perk.LegendSpecialistBlacksmith, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_bounty_hunter_background", ["scripts/skills/perks/perk_dodge"], [{def = ::Legends.Perk.Dodge, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_cannibal_background", ["scripts/skills/perks/perk_legend_camp_cook"], [{def = ::Legends.Perk.LegendCampCook, level = 0, optional = false}]);
	
//Lonewolf event bro
setupBackground("scripts/skills/backgrounds/legend_companion_melee_background", ["scripts/skills/perks/perk_brawny"], [{def = ::Legends.Perk.Brawny, level = 0, optional = false}]);
	
//Lonewolf event bro
setupBackground("scripts/skills/backgrounds/legend_companion_ranged_background", ["scripts/skills/perks/perk_legend_ballistics"], [{def = ::Legends.Perk.LegendBallistics, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_conscript_background", ["scripts/skills/perks/perk_dodge"], [{def = ::Legends.Perk.Dodge, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_crusader_background", ["scripts/skills/perks/perk_legend_favoured_enemy_zombie", "scripts/skills/perks/perk_legend_favoured_enemy_vampire"], [{def = ::Legends.Perk.LegendFavouredEnemyZombie, level = 0, optional = false}, {def = ::Legends.Perk.LegendFavouredEnemyVampire, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_dervish_background", ["scripts/skills/perks/perk_battle_flow"], [{def = ::Legends.Perk.BattleFlow, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_donkey_background", ["scripts/skills/perks/perk_legend_pacifist"], [{def = ::Legends.Perk.LegendPacifist, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_druid_background", ["scripts/skills/perks/perk_legend_herbcraft"], [{def = ::Legends.Perk.LegendHerbcraft, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_druid_commander_background", ["scripts/skills/perks/perk_legend_herbcraft"], [{def = ::Legends.Perk.LegendHerbcraft, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_guildmaster_background", ["scripts/skills/perks/perk_legend_net_repair"], [{def = ::Legends.Perk.LegendNetRepair, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_healer_background", ["scripts/skills/perks/perk_legend_mastery_bandage"], [{def = ::Legends.Perk.LegendSpecBandage, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_herbalist_background", ["scripts/skills/perks/perk_legend_herbcraft"], [{def = ::Legends.Perk.LegendHerbcraft, level = 0, optional = false}]);
	
// Cultist stuff
setupBackground("scripts/skills/backgrounds/legend_husk_background", ["scripts/skills/perks/perk_legend_specialist_cult_hood"], [{def = ::Legends.Perk.LegendSpecCultHood, level = 0, optional = false}]);
	
// Cultist stuff
setupBackground("scripts/skills/backgrounds/legend_lurker_background", ["scripts/skills/perks/perk_legend_specialist_cult_hood"], [{def = ::Legends.Perk.LegendSpecCultHood, level = 0, optional = false}]);
	
// Cultist stuff
setupBackground("scripts/skills/backgrounds/legend_magister_background", ["scripts/skills/perks/perk_legend_specialist_cult_armor"], [{def = ::Legends.Perk.LegendSpecCultArmor, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_inventor_background", ["scripts/skills/perks/perk_legend_inventor_anatomy"], [{def = ::Legends.Perk.LegendInventorAnatomy, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_ironmonger_background", ["scripts/skills/perks/perk_legend_tools_spares"], [{def = ::Legends.Perk.LegendToolsSpares, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_leech_peddler_background", ["scripts/skills/perks/perk_legend_med_ingredients"], [{def = ::Legends.Perk.LegendMedIngredients, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_lonewolf_background", ["scripts/skills/perks/perk_lone_wolf"], [{def = ::Legends.Perk.LoneWolf, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_man_at_arms_background", ["scripts/skills/perks/perk_shield_expert"], [{def = ::Legends.Perk.ShieldExpert, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/legend_master_archer_background", ["scripts/skills/perks/perk_legend_ballistics"], [{def = ::Legends.Perk.LegendBallistics, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_muladi_background", ["scripts/skills/perks/perk_legend_dogwhisperer"], [{def = ::Legends.Perk.LegendDogWhisperer, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_nightwatch_background", ["scripts/skills/perks/perk_legend_night_raider"], [{def = ::Legends.Perk.LegendNightRaider, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_noble_2h", ["scripts/skills/perks/perk_legend_forceful_swing"], [{def = ::Legends.Perk.LegendForcefulSwing, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_noble_background", ["scripts/skills/perks/perk_legend_assured_conquest"], [{def = ::Legends.Perk.LegendAssuredConquest, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_noble_commander_background", ["scripts/skills/perks/perk_legend_assured_conquest"], [{def = ::Legends.Perk.LegendAssuredConquest, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_noble_ranged", ["scripts/skills/perks/perk_legend_ballistics"], [{def = ::Legends.Perk.LegendBallistics, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_noble_shield", ["scripts/skills/perks/perk_shield_expert"], [{def = ::Legends.Perk.ShieldExpert, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_peddler_commander_background", ["scripts/skills/perks/perk_legend_barter_trustworthy"], [{def = ::Legends.Perk.LegendBarterTrustworthy, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_pilgrim_background", ["scripts/skills/perks/perk_legend_prayer_of_faith"], [{def = ::Legends.Perk.LegendPrayerOfFaith, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/legend_gladiator_prizefighter_background", ["scripts/skills/perks/perk_battle_flow"], [{def = ::Legends.Perk.BattleFlow, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_qiyan_background", ["scripts/skills/perks/perk_legend_barter_convincing"], [{def = ::Legends.Perk.LegendBarterConvincing, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_ranger_background", ["scripts/skills/perks/perk_legend_ammo_binding"], [{def = ::Legends.Perk.LegendAmmoBinding, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_ranger_commander_background", ["scripts/skills/perks/perk_legend_ammo_binding"], [{def = ::Legends.Perk.LegendAmmoBinding, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_shieldmaiden_background", ["scripts/skills/perks/perk_crGuardian"], [{def = ::Legends.Perk.crGuardian, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_taxidermist_background", ["scripts/skills/perks/perk_bags_and_belts"], [{def = ::Legends.Perk.BagsAndBelts, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_trader_background", ["scripts/skills/perks/perk_legend_off_book_deal"], [{def = ::Legends.Perk.LegendOffBookDeal, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_trader_commander_background", ["scripts/skills/perks/perk_legend_off_book_deal"], [{def = ::Legends.Perk.LegendOffBookDeal, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_vala_background", ["scripts/skills/perks/perk_legend_vala_warden"], [{def = ::Legends.Perk.LegendValaWarden, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_youngblood_background", ["scripts/skills/perks/perk_legend_favoured_enemy_hexen"], [{def = ::Legends.Perk.LegendFavouredEnemyHexen, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/lindwurm_slayer_background", ["scripts/skills/perks/perk_legend_favoured_enemy_lindwurm"], [{def = ::Legends.Perk.LegendFavouredEnemyLindwurm, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/lumberjack_background", ["scripts/skills/perks/perk_legend_specialist_woodsman"], [{def = ::Legends.Perk.LegendSpecialistWoodsman, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/manhunter_background", ["scripts/skills/perks/perk_dodge"], [{def = ::Legends.Perk.Dodge, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/mason_background", ["scripts/skills/perks/perk_crPerseverance"], [{def = ::Legends.Perk.crPerseverance, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/messenger_background", ["scripts/skills/perks/perk_legend_lookout"], [{def = ::Legends.Perk.LegendLookout, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/militia_background", ["scripts/skills/perks/perk_legend_specialist_militia"], [{def = ::Legends.Perk.LegendSpecialistMilitia, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/miller_background", ["scripts/skills/perks/perk_legend_camp_cook"], [{def = ::Legends.Perk.LegendCampCook, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/miner_background", ["scripts/skills/perks/perk_legend_specialist_miner"], [{def = ::Legends.Perk.LegendSpecialistMiner, level = 0, optional = false}]);

if (::mods_getRegisteredMod("mod_specialist_skills_rework") != null)
	setupBackground("scripts/skills/backgrounds/minstrel_background", ["scripts/skills/perks/perk_legend_daze"], [{def = ::Legends.Perk.LegendDaze, level = 0, optional = false}]);
else
	setupBackground("scripts/skills/backgrounds/minstrel_background", ["scripts/skills/perks/perk_legend_minnesanger"], [{def = ::Legends.Perk.LegendMinnesanger, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/monk_background", ["scripts/skills/perks/perk_legend_holyflame"], [{def = ::Legends.Perk.LegendHolyFlame, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/nomad_background", ["scripts/skills/perks/perk_legend_throw_sand"], [{def = ::Legends.Perk.LegendThrowSand, level = 0, optional = false}]);

// Greenskin Invasion Ranger
setupBackground("scripts/skills/backgrounds/orc_slayer_background", ["scripts/skills/perks/perk_legend_favoured_enemy_ork"], [{def = ::Legends.Perk.LegendFavouredEnemyOrk, level = 0, optional = false}]);

// Oathtaker
setupBackground("scripts/skills/backgrounds/paladin_background", ["scripts/skills/perks/perk_battle_forged"], [{def = ::Legends.Perk.BattleForged, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/peddler_background", ["scripts/skills/perks/perk_legend_barter_convincing"], [{def = ::Legends.Perk.LegendBarterConvincing, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/pimp_background", ["scripts/skills/perks/perk_legend_barter_convincing"], [{def = ::Legends.Perk.LegendBarterConvincing, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/poacher_background", ["scripts/skills/perks/perk_legend_lookout"], [{def = ::Legends.Perk.LegendLookout, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/raider_background", ["scripts/skills/perks/perk_legend_bloodbath"], [{def = ::Legends.Perk.LegendBloodbath, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/ratcatcher_background", ["scripts/skills/perks/perk_legend_net_casting"], [{def = ::Legends.Perk.LegendNetCasting, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/refugee_background", ["scripts/skills/perks/perk_underdog"], [{def = ::Legends.Perk.Underdog, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/regent_in_absentia_background", ["scripts/skills/perks/perk_legend_battleheart"], [{def = ::Legends.Perk.LegendBattleheart, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/retired_soldier_background", ["scripts/skills/perks/perk_legend_back_to_basics"], [{def = ::Legends.Perk.LegendBackToBasics, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/sellsword_background", ["scripts/skills/perks/perk_legend_barter_greed"], [{def = ::Legends.Perk.LegendBarterGreed, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/servant_background", ["scripts/skills/perks/perk_legend_meal_preperation"], [{def = ::Legends.Perk.LegendMealPreperation, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/shepherd_background", ["scripts/skills/perks/perk_legend_specialist_shepherd"], [{def = ::Legends.Perk.LegendSpecialistShepherd, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/slave_background", ["scripts/skills/perks/perk_legend_recuperation"], [{def = ::Legends.Perk.LegendRecuperation, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/squire_background", ["scripts/skills/perks/perk_legend_perfect_fit"], [{def = ::Legends.Perk.LegendPerfectFit, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/swordmaster_background", ["scripts/skills/perks/perk_duelist"], [{def = ::Legends.Perk.Duelist, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/tailor_background", ["scripts/skills/perks/perk_legend_tools_drawers"], [{def = ::Legends.Perk.LegendToolsDrawers, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/thief_background", ["scripts/skills/perks/perk_dodge"], [{def = ::Legends.Perk.Dodge, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/vagabond_background", ["scripts/skills/perks/perk_fast_adaption"], [{def = ::Legends.Perk.FastAdaption, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/wildman_background", ["scripts/skills/perks/perk_legend_gatherer"], [{def = ::Legends.Perk.LegendGatherer, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/witchhunter_background", ["scripts/skills/perks/perk_legend_favoured_enemy_hexen"], [{def = ::Legends.Perk.LegendFavouredEnemyHexen, level = 0, optional = false}]);
