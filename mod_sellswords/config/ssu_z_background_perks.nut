// Helper function to setup a background with specific perks
::Mod_Sellswords.setupBackground <- function (classPath, perkScripts, perkDefs)
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

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/anatomist_background", ["scripts/skills/perks/perk_crippling_strikes"], [{def = ::Legends.Perk.CripplingStrikes, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/apprentice_background", ["scripts/skills/perks/perk_student"], [{def = ::Legends.Perk.Student, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/assassin_background", ["scripts/skills/perks/perk_legend_opportunist"], [{def = ::Legends.Perk.LegendOpportunist, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/assassin_southern_background", ["scripts/skills/perks/perk_legend_opportunist"], [{def = ::Legends.Perk.LegendOpportunist, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/barbarian_background", ["scripts/skills/perks/perk_berserk"], [{def = ::Legends.Perk.Berserk, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/bastard_background", ["scripts/skills/perks/perk_underdog"], [{def = ::Legends.Perk.Underdog, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/beast_hunter_background", ["scripts/skills/perks/perk_legend_mastery_nets"], [{def = ::Legends.Perk.LegendMasteryNets, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/beggar_background", ["scripts/skills/perks/perk_underdog"], [{def = ::Legends.Perk.Underdog, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/belly_dancer_background", ["scripts/skills/perks/perk_nimble"], [{def = ::Legends.Perk.Nimble, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/bowyer_background", ["scripts/skills/perks/perk_legend_wind_reader"], [{def = ::Legends.Perk.LegendWindReader, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/brawler_background", ["scripts/skills/perks/perk_legend_grappler"], [{def = ::Legends.Perk.LegendGrappler, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/butcher_background", ["scripts/skills/perks/perk_legend_slaughterer"], [{def = ::Legends.Perk.LegendSlaughterer, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/caravan_hand_background", ["scripts/skills/perks/perk_bags_and_belts"], [{def = ::Legends.Perk.BagsAndBelts, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/companion_1h_background", ["scripts/skills/perks/perk_legend_feint"], [{def = ::Legends.Perk.LegendFeint, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/companion_2h_background", ["scripts/skills/perks/perk_legend_bloody_harvest"], [{def = ::Legends.Perk.LegendBloodyHarvest, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/companion_ranged_background", ["scripts/skills/perks/perk_bullseye"], [{def = ::Legends.Perk.Bullseye, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/converted_cultist_background", ["scripts/skills/perks/perk_legend_dedication"], [{def = ::Legends.Perk.LegendDedication, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/cripple_background", ["scripts/skills/perks/perk_legend_blend_in"], [{def = ::Legends.Perk.LegendBlendIn, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/crucified_background", ["scripts/skills/perks/perk_nine_lives"], [{def = ::Legends.Perk.NineLives, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/crusader_background", ["scripts/skills/perks/perk_legend_true_believer"], [{def = ::Legends.Perk.LegendTrueBeliever, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/cultist_background", ["scripts/skills/perks/perk_legend_dedication"], [{def = ::Legends.Perk.LegendDedication, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/daytaler_background", ["scripts/skills/perks/perk_colossus"], [{def = ::Legends.Perk.Colossus, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/deserter_background", ["scripts/skills/perks/perk_legend_back_to_basics"], [{def = ::Legends.Perk.LegendBackToBasics, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/eunuch_background", ["scripts/skills/perks/perk_legend_pacifist"], [{def = ::Legends.Perk.LegendPacifist, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/executioner_background", ["scripts/skills/perks/perk_coup_de_grace"], [{def = ::Legends.Perk.CoupDeGrace, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/farmhand_background", ["scripts/skills/perks/perk_brawny"], [{def = ::Legends.Perk.Brawny, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/fisherman_background", ["scripts/skills/perks/perk_legend_net_casting"], [{def = ::Legends.Perk.LegendNetCasting, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/flagellant_background", ["scripts/skills/perks/perk_legend_vengeance"], [{def = ::Legends.Perk.LegendVengeance, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/gambler_background", ["scripts/skills/perks/perk_legend_sleight_of_hand"], [{def = ::Legends.Perk.LegendSleightOfHand, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/gladiator_background", ["scripts/skills/perks/perk_battle_flow"], [{def = ::Legends.Perk.BattleFlow, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/gravedigger_background", ["scripts/skills/perks/perk_hold_out"], [{def = ::Legends.Perk.HoldOut, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/graverobber_background", ["scripts/skills/perks/perk_legend_nightvision"], [{def = ::Legends.Perk.LegendNightvision, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/hedge_knight_background", ["scripts/skills/perks/perk_steel_brow"], [{def = ::Legends.Perk.SteelBrow, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/historian_background", ["scripts/skills/perks/perk_student"], [{def = ::Legends.Perk.Student, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/houndmaster_background", ["scripts/skills/perks/perk_legend_dog_whisperer"], [{def = ::Legends.Perk.LegendDogWhisperer, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/hunter_background", ["scripts/skills/perks/perk_legend_ballistics"], [{def = ::Legends.Perk.LegendBallistics, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/juggler_background", ["scripts/skills/perks/perk_legend_hair_splitter"], [{def = ::Legends.Perk.LegendHairSplitter, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/killer_on_the_run_background", ["scripts/skills/perks/perk_backstabber"], [{def = ::Legends.Perk.Backstabber, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/kings_guard_background", ["scripts/skills/perks/perk_rotation"], [{def = ::Legends.Perk.Rotation, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_alchemist_background", ["scripts/skills/perks/perk_legend_prepared"], [{def = ::Legends.Perk.LegendPrepared, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_arbalester_background", ["scripts/skills/perks/perk_legend_ballistics"], [{def = ::Legends.Perk.LegendBallistics, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_battle_sister_background", ["scripts/skills/perks/perk_legend_prayer_of_faith"], [{def = ::Legends.Perk.LegendPrayerOfFaith, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_beggar_commander_op_background", ["scripts/skills/perks/perk_legend_blend_in"], [{def = ::Legends.Perk.LegendBlendIn, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_belly_dancer_background", ["scripts/skills/perks/perk_legend_manipulative"], [{def = ::Legends.Perk.LegendManipulative, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_berserker_background", ["scripts/skills/perks/perk_killing_frenzy"], [{def = ::Legends.Perk.KillingFrenzy, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_blacksmith_background", ["scripts/skills/perks/perk_legend_hammer_the_gap"], [{def = ::Legends.Perk.LegendHammerTheGap, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_bladedancer_background", ["scripts/skills/perks/perk_legend_feint"], [{def = ::Legends.Perk.LegendFeint, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_bounty_hunter_background", ["scripts/skills/perks/perk_dodge"], [{def = ::Legends.Perk.Dodge, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_commander_assassin_background", ["scripts/skills/perks/perk_legend_opportunist"], [{def = ::Legends.Perk.LegendOpportunist, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_commander_beggar_background", ["scripts/skills/perks/perk_legend_blend_in"], [{def = ::Legends.Perk.LegendBlendIn, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_commander_berserker_background", ["scripts/skills/perks/perk_killing_frenzy"], [{def = ::Legends.Perk.KillingFrenzy, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_commander_crusader_background", ["scripts/skills/perks/perk_legend_true_believer", "scripts/skills/perks/perk_legend_holy_flame"], [{def = ::Legends.Perk.LegendTrueBeliever, level = 0, optional = false}, {def = ::Legends.Perk.LegendHolyFlame, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_commander_necro_background", ["scripts/skills/perks/perk_legend_conservation"], [{def = ::Legends.Perk.LegendConservation, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_commander_noble_background", ["scripts/skills/perks/perk_legend_assured_conquest"], [{def = ::Legends.Perk.LegendAssuredConquest, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_commander_peddler_background", ["scripts/skills/perks/perk_legend_pacifist"], [{def = ::Legends.Perk.LegendPacifist, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_commander_ranger_background", ["scripts/skills/perks/perk_legend_keen_eyesight"], [{def = ::Legends.Perk.LegendKeenEyesight, level = 0, optional = false}]);

//Lonewolf event bro
::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_companion_melee_background", ["scripts/skills/perks/perk_brawny"], [{def = ::Legends.Perk.Brawny, level = 0, optional = false}]);

//Lonewolf event bro
::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_companion_ranged_background", ["scripts/skills/perks/perk_legend_ballistics"], [{def = ::Legends.Perk.LegendBallistics, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_conscript_background", ["scripts/skills/perks/perk_dodge"], [{def = ::Legends.Perk.Dodge, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_dervish_background", ["scripts/skills/perks/perk_battle_flow"], [{def = ::Legends.Perk.BattleFlow, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_donkey_background", ["scripts/skills/perks/perk_legend_pacifist"], [{def = ::Legends.Perk.LegendPacifist, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_druid_background", ["scripts/skills/perks/perk_pathfinder"], [{def = ::Legends.Perk.Pathfinder, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_foot_soldier_background", ["scripts/skills/perks/perk_legend_bloody_harvest"], [{def = ::Legends.Perk.LegendBloodyHarvest, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_gladiator_prizefighter_background", ["scripts/skills/perks/perk_battle_flow"], [{def = ::Legends.Perk.BattleFlow, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_guild_master_background", ["scripts/skills/perks/perk_legend_mastery_nets"], [{def = ::Legends.Perk.LegendMasteryNets, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_herbalist_background", ["scripts/skills/perks/perk_legend_poisoner"], [{def = ::Legends.Perk.LegendPoisoner, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_house_guard_background", ["scripts/skills/perks/perk_shield_expert"], [{def = ::Legends.Perk.ShieldExpert, level = 0, optional = false}]);

// Cultist stuff
::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_husk_background", ["scripts/skills/perks/perk_legend_dedication"], [{def = ::Legends.Perk.LegendDedication, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_illusionist_background", ["scripts/skills/perks/perk_dodge"], [{def = ::Legends.Perk.Dodge, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_inventor_background", ["scripts/skills/perks/perk_legend_prepared"], [{def = ::Legends.Perk.LegendPrepared, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_ironmonger_background", ["scripts/skills/perks/perk_legend_smackdown"], [{def = ::Legends.Perk.LegendSmackdown, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_leech_peddler_background", ["scripts/skills/perks/perk_legend_recuperation"], [{def = ::Legends.Perk.LegendRecuperation, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_legion_background", ["scripts/skills/perks/perk_legend_back_to_basics"], [{def = ::Legends.Perk.LegendBackToBasics, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_lone_wolf_background", ["scripts/skills/perks/perk_lone_wolf"], [{def = ::Legends.Perk.LoneWolf, level = 0, optional = false}]);

// Cultist stuff
::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_lurker_background", ["scripts/skills/perks/perk_legend_lurker"], [{def = ::Legends.Perk.LegendLurker, level = 0, optional = false}]);

// Cultist stuff
::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_magister_background", ["scripts/skills/perks/perk_legend_penance"], [{def = ::Legends.Perk.LegendPenance, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_man_at_arms_background", ["scripts/skills/perks/perk_shield_expert"], [{def = ::Legends.Perk.ShieldExpert, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_master_archer_background", ["scripts/skills/perks/perk_legend_ballistics"], [{def = ::Legends.Perk.LegendBallistics, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_muladi_background", ["scripts/skills/perks/perk_legend_dog_whisperer"], [{def = ::Legends.Perk.LegendDogWhisperer, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_necromancer_background", ["scripts/skills/perks/perk_legend_conservation"], [{def = ::Legends.Perk.LegendConservation, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_necrosavant_background", ["scripts/skills/perks/perk_legend_night_raider"], [{def = ::Legends.Perk.LegendNightRaider, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_nightwatch_background", ["scripts/skills/perks/perk_legend_night_raider"], [{def = ::Legends.Perk.LegendNightRaider, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_pilgrim_background", ["scripts/skills/perks/perk_legend_prayer_of_faith"], [{def = ::Legends.Perk.LegendPrayerOfFaith, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_preserver_background", ["scripts/skills/perks/perk_legend_conservation"], [{def = ::Legends.Perk.LegendConservation, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_puppet_background", ["scripts/skills/perks/perk_nine_lives"], [{def = ::Legends.Perk.NineLives, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_puppet_master_background", ["scripts/skills/perks/perk_legend_conservation"], [{def = ::Legends.Perk.LegendConservation, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_reanimator_background", ["scripts/skills/perks/perk_legend_conservation"], [{def = ::Legends.Perk.LegendConservation, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_seer_background", ["scripts/skills/perks/perk_fortified_mind"], [{def = ::Legends.Perk.FortifiedMind, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_shieldmaiden_background", ["scripts/skills/perks/perk_ssu_guardian"], [{def = ::Legends.Perk.SsuGuardian, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_surgeon_background", ["scripts/skills/perks/perk_legend_recuperation"], [{def = ::Legends.Perk.LegendRecuperation, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_taxidermist_background", ["scripts/skills/perks/perk_bags_and_belts"], [{def = ::Legends.Perk.BagsAndBelts, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_vala_background", ["scripts/skills/perks/perk_legend_vala_warden"], [{def = ::Legends.Perk.LegendValaWarden, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_warden_background", ["scripts/skills/perks/perk_legend_keen_eyesight"], [{def = ::Legends.Perk.LegendKeenEyesight, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_warlock_background", ["scripts/skills/perks/perk_legend_conservation"], [{def = ::Legends.Perk.LegendConservation, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/legend_youngblood_background", ["scripts/skills/perks/perk_student"], [{def = ::Legends.Perk.Student, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/lindwurm_slayer_background", ["scripts/skills/perks/perk_legend_big_game_hunter"], [{def = ::Legends.Perk.LegendBigGameHunter, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/lumberjack_background", ["scripts/skills/perks/perk_legend_smashing_shields"], [{def = ::Legends.Perk.LegendSmashingShields, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/manhunter_background", ["scripts/skills/perks/perk_dodge"], [{def = ::Legends.Perk.Dodge, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/mason_background", ["scripts/skills/perks/perk_ssu_perseverance"], [{def = ::Legends.Perk.SsuPerseverance, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/messenger_background", ["scripts/skills/perks/perk_pathfinder"], [{def = ::Legends.Perk.Pathfinder, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/militia_background", ["scripts/skills/perks/perk_legend_spearwaller"], [{def = ::Legends.Perk.LegendSpearwaller, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/miller_background", ["scripts/skills/perks/perk_recover"], [{def = ::Legends.Perk.Recover, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/miner_background", ["scripts/skills/perks/perk_legend_bone_breaker"], [{def = ::Legends.Perk.LegendBoneBreaker, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/minstrel_background", ["scripts/skills/perks/perk_legend_minnesanger"], [{def = ::Legends.Perk.LegendMinnesanger, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/monk_background", ["scripts/skills/perks/perk_legend_holy_flame"], [{def = ::Legends.Perk.LegendHolyFlame, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/monk_turned_flagellant_background", ["scripts/skills/perks/perk_legend_mind_over_body"], [{def = ::Legends.Perk.LegendMindOverBody, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/nomad_background", ["scripts/skills/perks/perk_legend_throw_sand"], [{def = ::Legends.Perk.LegendThrowSand, level = 0, optional = false}]);

// Greenskin Invasion Ranger
::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/orc_slayer_background", ["scripts/skills/perks/perk_head_hunter"], [{def = ::Legends.Perk.HeadHunter, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/pacified_flagellant_background", ["scripts/skills/perks/perk_legend_pacifist"], [{def = ::Legends.Perk.LegendPacifist, level = 0, optional = false}]);

// Oathtaker
::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/paladin_background", ["scripts/skills/perks/perk_battle_forged"], [{def = ::Legends.Perk.BattleForged, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/peddler_background", ["scripts/skills/perks/perk_legend_pacifist"], [{def = ::Legends.Perk.LegendPacifist, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/pimp_background", ["scripts/skills/perks/perk_legend_manipulative"], [{def = ::Legends.Perk.LegendManipulative, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/poacher_background", ["scripts/skills/perks/perk_legend_patient_hunter"], [{def = ::Legends.Perk.LegendPatientHunter, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/raider_background", ["scripts/skills/perks/perk_legend_bloodbath"], [{def = ::Legends.Perk.LegendBloodbath, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/ratcatcher_background", ["scripts/skills/perks/perk_legend_net_casting"], [{def = ::Legends.Perk.LegendNetCasting, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/refugee_background", ["scripts/skills/perks/perk_underdog"], [{def = ::Legends.Perk.Underdog, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/regent_in_absentia_background", ["scripts/skills/perks/perk_legend_battleheart"], [{def = ::Legends.Perk.LegendBattleheart, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/retired_soldier_background", ["scripts/skills/perks/perk_legend_back_to_basics"], [{def = ::Legends.Perk.LegendBackToBasics, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/sellsword_background", ["scripts/skills/perks/perk_legend_back_to_basics"], [{def = ::Legends.Perk.LegendBackToBasics, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/ssu_dryad_archer_background", ["scripts/skills/perks/perk_legend_ballistics"], [{def = ::Legends.Perk.LegendBallistics, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/ssu_dryad_avatar_background", ["scripts/skills/perks/perk_legend_roots"], [{def = ::Legends.Perk.LegendRoots, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/ssu_dryad_grunt_background", ["scripts/skills/perks/perk_colossus"], [{def = ::Legends.Perk.Colossus, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/ssu_dryad_shaman_background", ["scripts/skills/perks/perk_legend_roots"], [{def = ::Legends.Perk.LegendRoots, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/ssu_dryad_tamer_background", ["scripts/skills/perks/perk_pathfinder"], [{def = ::Legends.Perk.Pathfinder, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/ssu_dryad_warrior_background", ["scripts/skills/perks/perk_battle_forged"], [{def = ::Legends.Perk.BattleForged, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/ssu_necro_ancient_auxiliary", ["scripts/skills/perks/perk_shield_expert"], [{def = ::Legends.Perk.ShieldExpert, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/ssu_necro_ancient_honour_guard", ["scripts/skills/perks/perk_battle_forged"], [{def = ::Legends.Perk.BattleForged, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/ssu_necro_ancient_legionary", ["scripts/skills/perks/perk_reach_advantage"], [{def = ::Legends.Perk.ReachAdvantage, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/ssu_necro_embalmbed_priest", ["scripts/skills/perks/perk_legend_miasma"], [{def = ::Legends.Perk.LegendMiasma, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/ssu_necro_embalmbed_slave", ["scripts/skills/perks/perk_nine_lives"], [{def = ::Legends.Perk.NineLives, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/ssu_necro_embalmbed_soldier", ["scripts/skills/perks/perk_fearsome"], [{def = ::Legends.Perk.Fearsome, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/ssu_necro_fallen_hero", ["scripts/skills/perks/perk_ssu_necro_zombie_fallen_hero"], [{def = ::Legends.Perk.SsuNecroZombieFallenHero, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/ssu_necro_necrosavant", ["scripts/skills/perks/perk_legend_darkflight"], [{def = ::Legends.Perk.LegendDarkflight, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/ssu_necro_zombie", ["scripts/skills/perks/perk_colossus"], [{def = ::Legends.Perk.Colossus, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/ssu_sellsword_background", ["scripts/skills/perks/perk_legend_battleheart"], [{def = ::Legends.Perk.LegendBattleheart, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/servant_background", ["scripts/skills/perks/perk_legend_alert"], [{def = ::Legends.Perk.LegendAlert, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/shepherd_background", ["scripts/skills/perks/perk_legend_mastery_slings"], [{def = ::Legends.Perk.LegendMasterySlings, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/slave_background", ["scripts/skills/perks/perk_legend_recuperation"], [{def = ::Legends.Perk.LegendRecuperation, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/squire_background", ["scripts/skills/perks/perk_legend_perfect_fit"], [{def = ::Legends.Perk.LegendPerfectFit, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/swordmaster_background", ["scripts/skills/perks/perk_duelist"], [{def = ::Legends.Perk.Duelist, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/tailor_background", ["scripts/skills/perks/perk_legend_fashionable"], [{def = ::Legends.Perk.LegendFashionable, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/thief_background", ["scripts/skills/perks/perk_dodge"], [{def = ::Legends.Perk.Dodge, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/vagabond_background", ["scripts/skills/perks/perk_fast_adaption"], [{def = ::Legends.Perk.FastAdaption, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/wildman_background", ["scripts/skills/perks/perk_pathfinder"], [{def = ::Legends.Perk.Pathfinder, level = 0, optional = false}]);

::Mod_Sellswords.setupBackground("scripts/skills/backgrounds/witchhunter_background", ["scripts/skills/perks/perk_fortified_mind"], [{def = ::Legends.Perk.FortifiedMind, level = 0, optional = false}]);
