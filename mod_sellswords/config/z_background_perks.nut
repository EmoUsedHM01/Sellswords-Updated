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

			local addPerk = function ( _perk, _row = 0 )
			{
				local hasRow = false;
				local direction = -1;
				local row = _row;
				while (row >= 0 && row <= 6)
				{
					if (this.m.CustomPerkTree[row].len() < 13)
					{
						hasRow = true;
						break;
					}

					row += direction;

					if (row == -1)
					{
						row = _row;
						direction = 1;
					}
				}

				row = hasRow ? this.Math.max(0, this.Math.min(row, 6)) : _row;
				this.addPerk(_perk, row);
			}

			foreach (perkDef in perkDefs)
				addPerk(perkDef.def, perkDef.level, perkDef.optional);
		}

	});
}

// Define each background using the helper function
setupBackground("scripts/skills/backgrounds/adventurous_noble_background", ["scripts/skills/perks/perk_rotation"], [{def = ::Const.Perks.PerkDefs.Rotation, level = 0, optional = false}, {def = ::Const.Perks.PerkDefs.crFurinkazan, level = 1, optional = false}]);

setupBackground("scripts/skills/backgrounds/anatomist_background", ["scripts/skills/perks/perk_debilitate"], [{def = ::Const.Perks.PerkDefs.Debilitate, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/apprentice_background", ["scripts/skills/perks/perk_student"], [{def = ::Const.Perks.PerkDefs.Student, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/assassin_background", ["scripts/skills/perks/perk_legend_opportunist"], [{def = ::Const.Perks.PerkDefs.LegendOpportunist, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/assassin_southern_background", ["scripts/skills/perks/perk_legend_opportunist"], [{def = ::Const.Perks.PerkDefs.LegendOpportunist, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/barbarian_background", ["scripts/skills/perks/perk_berserk"], [{def = ::Const.Perks.PerkDefs.Berserk, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/bastard_background", ["scripts/skills/perks/perk_underdog"], [{def = ::Const.Perks.PerkDefs.Underdog, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/beast_hunter_background", ["scripts/skills/perks/perk_legend_net_repair"], [{def = ::Const.Perks.PerkDefs.LegendNetRepair, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/beggar_background", ["scripts/skills/perks/perk_underdog"], [{def = ::Const.Perks.PerkDefs.Underdog, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/belly_dancer_background", ["scripts/skills/perks/perk_legend_twirl"], [{def = ::Const.Perks.PerkDefs.LegendTwirl, level = 0, optional = false}, {def = ::Const.Perks.PerkDefs.crFurinkazan, level = 1, optional = false}]);

setupBackground("scripts/skills/backgrounds/bowyer_background", ["scripts/skills/perks/perk_legend_specialist_shortbow_skill"], [{def = ::Const.Perks.PerkDefs.LegendSpecialistShortbowSkill, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/brawler_background", ["scripts/skills/perks/perk_legend_grapple"], [{def = ::Const.Perks.PerkDefs.LegendGrapple, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/butcher_background", ["scripts/skills/perks/perk_legend_specialist_butcher_skill"], [{def = ::Const.Perks.PerkDefs.LegendSpecialistButcherSkill, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/caravan_hand_background", ["scripts/skills/perks/perk_legend_efficient_packing"], [{def = ::Const.Perks.PerkDefs.LegendEfficientPacking, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/companion_1h_background", ["scripts/skills/perks/perk_feint"], [{def = ::Const.Perks.PerkDefs.Feint, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/companion_2h_background", ["scripts/skills/perks/perk_bloody_harvest"], [{def = ::Const.Perks.PerkDefs.BloodyHarvest, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/companion_ranged_background", ["scripts/skills/perks/perk_bullseye"], [{def = ::Const.Perks.PerkDefs.Bullseye, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/cripple_background", ["scripts/skills/perks/perk_legend_blend_in"], [{def = ::Const.Perks.PerkDefs.LegendBlendIn, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/crusader_background", ["scripts/skills/perks/perk_legend_favoured_enemy_zombie"], [{def = ::Const.Perks.PerkDefs.LegendFavouredEnemyZombie, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/cultist_background", ["scripts/skills/perks/perk_legend_specialist_cult_hood"], [{def = ::Const.Perks.PerkDefs.LegendSpecCultHood, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/daytaler_background", ["scripts/skills/perks/perk_colossus"], [{def = ::Const.Perks.PerkDefs.Colossus, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/deserter_background", ["scripts/skills/perks/perk_legend_back_to_basics"], [{def = ::Const.Perks.PerkDefs.LegendBackToBasics, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/disowned_noble_background", ["scripts/skills/perks/perk_legend_assured_conquest"], [{def = ::Const.Perks.PerkDefs.LegendAssuredConquest, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/eunuch_background", ["scripts/skills/perks/perk_legend_helpful"], [{def = ::Const.Perks.PerkDefs.LegendHelpful, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/farmhand_background", ["scripts/skills/perks/perk_legend_specialist_pitchfork_skill"], [{def = ::Const.Perks.PerkDefs.LegendSpecialistPitchforkSkill, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/female_adventurous_noble_background", ["scripts/skills/perks/perk_bullseye"], [{def = ::Const.Perks.PerkDefs.Bullseye, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/female_disowned_noble_background", ["scripts/skills/perks/perk_rotation"], [{def = ::Const.Perks.PerkDefs.Rotation, level = 0, optional = false}, {def = ::Const.Perks.PerkDefs.crFurinkazan, level = 1, optional = false}]);

setupBackground("scripts/skills/backgrounds/fisherman_background", ["scripts/skills/perks/perk_legend_net_casting"], [{def = ::Const.Perks.PerkDefs.LegendNetCasting, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/flagellant_background", ["scripts/skills/perks/perk_legend_specialist_ninetails_skill"], [{def = ::Const.Perks.PerkDefs.LegendSpecialistNinetailsSkill, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/gambler_background", ["scripts/skills/perks/perk_legend_barter_greed"], [{def = ::Const.Perks.PerkDefs.LegendBarterGreed, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/gladiator_background", ["scripts/skills/perks/perk_battle_flow"], [{def = ::Const.Perks.PerkDefs.BattleFlow, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/gravedigger_background", ["scripts/skills/perks/perk_legend_specialist_shovel_skill"], [{def = ::Const.Perks.PerkDefs.LegendSpecialistShovelSkill, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/graverobber_background", ["scripts/skills/perks/perk_legend_specialist_shovel_skill"], [{def = ::Const.Perks.PerkDefs.LegendSpecialistShovelSkill, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/hedge_knight_background", ["scripts/skills/perks/perk_steel_brow"], [{def = ::Const.Perks.PerkDefs.SteelBrow, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/historian_background", ["scripts/skills/perks/perk_legend_scholar"], [{def = ::Const.Perks.PerkDefs.LegendScholar, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/houndmaster_background", ["scripts/skills/perks/perk_legend_dogwhisperer"], [{def = ::Const.Perks.PerkDefs.LegendDogWhisperer, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/hunter_background", ["scripts/skills/perks/perk_ballistics"], [{def = ::Const.Perks.PerkDefs.Ballistics, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/juggler_background", ["scripts/skills/perks/perk_legend_hair_splitter"], [{def = ::Const.Perks.PerkDefs.LegendHairSplitter, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/killer_on_the_run_background", ["scripts/skills/perks/perk_backstabber"], [{def = ::Const.Perks.PerkDefs.Backstabber, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_alchemist_background", ["scripts/skills/perks/perk_legend_potion_brewer"], [{def = ::Const.Perks.PerkDefs.LegendPotionBrewer, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_assassin_background", ["scripts/skills/perks/perk_legend_opportunist"], [{def = ::Const.Perks.PerkDefs.LegendOpportunist, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_assassin_commander_background", ["scripts/skills/perks/perk_legend_opportunist"], [{def = ::Const.Perks.PerkDefs.LegendOpportunist, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_beggar_commander_background", ["scripts/skills/perks/perk_legend_blend_in"], [{def = ::Const.Perks.PerkDefs.LegendBlendIn, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_beggar_commander_op_background", ["scripts/skills/perks/perk_legend_blend_in"], [{def = ::Const.Perks.PerkDefs.LegendBlendIn, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_berserker_background", ["scripts/skills/perks/perk_adrenalin"], [{def = ::Const.Perks.PerkDefs.Adrenaline, level = 0, optional = false}, {def = ::Const.Perks.PerkDefs.crirresistibleimpulse, level = 1, optional = false}]);

	
setupBackground("scripts/skills/backgrounds/legend_berserker_commander_background", ["scripts/skills/perks/perk_adrenalin"], [{def = ::Const.Perks.PerkDefs.Adrenaline, level = 0, optional = false}, {def = ::Const.Perks.PerkDefs.crirresistibleimpulse, level = 1, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_blacksmith_background", ["scripts/skills/perks/perk_legend_specialist_hammer_skill"], [{def = ::Const.Perks.PerkDefs.LegendSpecialistHammerSkill, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_bounty_hunter_background", ["scripts/skills/perks/perk_dodge"], [{def = ::Const.Perks.PerkDefs.Dodge, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_cannibal_background", ["scripts/skills/perks/perk_legend_camp_cook"], [{def = ::Const.Perks.PerkDefs.LegendCampCook, level = 0, optional = false}]);
	
//Lonewolf event bro
setupBackground("scripts/skills/backgrounds/legend_companion_melee_background", ["scripts/skills/perks/perk_brawny"], [{def = ::Const.Perks.PerkDefs.Brawny, level = 0, optional = false}]);
	
//Lonewolf event bro
setupBackground("scripts/skills/backgrounds/legend_companion_ranged_background", ["scripts/skills/perks/perk_ballistics"], [{def = ::Const.Perks.PerkDefs.Ballistics, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_conscript_background", ["scripts/skills/perks/perk_dodge"], [{def = ::Const.Perks.PerkDefs.Dodge, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_crusader_background", ["scripts/skills/perks/perk_legend_favoured_enemy_zombie"], [{def = ::Const.Perks.PerkDefs.LegendFavouredEnemyZombie, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_crusader_commander_background", ["scripts/skills/perks/perk_legend_favoured_enemy_vampire"], [{def = ::Const.Perks.PerkDefs.LegendFavouredEnemyVampire, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_dervish_background", ["scripts/skills/perks/perk_battle_flow"], [{def = ::Const.Perks.PerkDefs.BattleFlow, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_donkey_background", ["scripts/skills/perks/perk_legend_pacifist"], [{def = ::Const.Perks.PerkDefs.LegendPacifist, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_druid_background", ["scripts/skills/perks/perk_legend_herbcraft"], [{def = ::Const.Perks.PerkDefs.LegendHerbcraft, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_druid_commander_background", ["scripts/skills/perks/perk_legend_herbcraft"], [{def = ::Const.Perks.PerkDefs.LegendHerbcraft, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_guildmaster_background", ["scripts/skills/perks/perk_legend_net_repair"], [{def = ::Const.Perks.PerkDefs.LegendNetRepair, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_healer_background", ["scripts/skills/perks/perk_legend_mastery_bandage"], [{def = ::Const.Perks.PerkDefs.LegendSpecBandage, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_herbalist_background", ["scripts/skills/perks/perk_legend_herbcraft"], [{def = ::Const.Perks.PerkDefs.LegendHerbcraft, level = 0, optional = false}]);
	
// Cultist stuff
setupBackground("scripts/skills/backgrounds/legend_husk_background", ["scripts/skills/perks/perk_legend_specialist_cult_hood"], [{def = ::Const.Perks.PerkDefs.LegendSpecCultHood, level = 0, optional = false}]);
	
// Cultist stuff
setupBackground("scripts/skills/backgrounds/legend_lurker_background", ["scripts/skills/perks/perk_legend_specialist_cult_hood"], [{def = ::Const.Perks.PerkDefs.LegendSpecCultHood, level = 0, optional = false}]);
	
// Cultist stuff
setupBackground("scripts/skills/backgrounds/legend_magister_background", ["scripts/skills/perks/perk_legend_specialist_cult_armor"], [{def = ::Const.Perks.PerkDefs.LegendSpecCultArmor, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_inventor_background", ["scripts/skills/perks/legend_inventor_anatomy"], [{def = ::Const.Perks.PerkDefs.LegendInventorAnatomy, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_ironmonger_background", ["scripts/skills/perks/perk_legend_tools_spares"], [{def = ::Const.Perks.PerkDefs.LegendToolsSpares, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_leech_peddler_background", ["scripts/skills/perks/perk_legend_med_ingredients"], [{def = ::Const.Perks.PerkDefs.LegendMedIngredients, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_lonewolf_background", ["scripts/skills/perks/perk_lone_wolf"], [{def = ::Const.Perks.PerkDefs.LoneWolf, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_man_at_arms_background", ["scripts/skills/perks/perk_crGuardian"], [{def = ::Const.Perks.PerkDefs.crGuardian, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_master_archer_background", ["scripts/skills/perks/perk_ballistics"], [{def = ::Const.Perks.PerkDefs.Ballistics, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_muladi_background", ["scripts/skills/perks/perk_legend_dogwhisperer"], [{def = ::Const.Perks.PerkDefs.LegendDogWhisperer, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_nightwatch_background", ["scripts/skills/perks/perk_legend_night_raider"], [{def = ::Const.Perks.PerkDefs.LegendNightRaider, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_noble_2h", ["scripts/skills/perks/perk_legend_forceful_swing"], [{def = ::Const.Perks.PerkDefs.LegendForcefulSwing, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_noble_background", ["scripts/skills/perks/perk_legend_assured_conquest"], [{def = ::Const.Perks.PerkDefs.LegendAssuredConquest, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_noble_commander_background", ["scripts/skills/perks/perk_legend_assured_conquest"], [{def = ::Const.Perks.PerkDefs.LegendAssuredConquest, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_noble_ranged", ["scripts/skills/perks/perk_crParthianshot"], [{def = ::Const.Perks.PerkDefs.crParthianshot, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_noble_shield", ["scripts/skills/perks/perk_shield_expert"], [{def = ::Const.Perks.PerkDefs.ShieldExpert, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_peddler_commander_background", ["scripts/skills/perks/perk_legend_barter_trustworthy"], [{def = ::Const.Perks.PerkDefs.LegendBarterTrustworthy, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_pilgrim_background", ["scripts/skills/perks/perk_legend_prayer_of_faith"], [{def = ::Const.Perks.PerkDefs.LegendPrayerOfFaith, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_qiyan_background", ["scripts/skills/perks/perk_legend_barter_convincing"], [{def = ::Const.Perks.PerkDefs.LegendBarterConvincing, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_ranger_background", ["scripts/skills/perks/perk_legend_ammo_binding"], [{def = ::Const.Perks.PerkDefs.LegendAmmoBinding, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_ranger_commander_background", ["scripts/skills/perks/perk_legend_ammo_binding"], [{def = ::Const.Perks.PerkDefs.LegendAmmoBinding, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_shieldmaiden_background", ["scripts/skills/perks/perk_crGuardian"], [{def = ::Const.Perks.PerkDefs.crGuardian, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_taxidermist_background", ["scripts/skills/perks/perk_bags_and_belts"], [{def = ::Const.Perks.PerkDefs.BagsAndBelts, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_trader_background", ["scripts/skills/perks/legends/off_book_deal"], [{def = ::Const.Perks.PerkDefs.LegendOffBookDeal, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_trader_commander_background", ["scripts/skills/perks/legends/off_book_deal"], [{def = ::Const.Perks.PerkDefs.LegendOffBookDeal, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_vala_background", ["scripts/skills/perks/legend_vala_warden"], [{def = ::Const.Perks.PerkDefs.LegendValaWarden, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_vala_commander_background", ["scripts/skills/perks/legend_vala_warden"], [{def = ::Const.Perks.PerkDefs.LegendValaWarden, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/legend_youngblood_background", ["scripts/skills/perks/perk_legend_favoured_enemy_hexen"], [{def = ::Const.Perks.PerkDefs.LegendFavouredEnemyHexen, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/lindwurm_slayer_background", ["scripts/skills/perks/perk_legend_favoured_enemy_lindwurm"], [{def = ::Const.Perks.PerkDefs.LegendFavouredEnemyLindwurm, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/lumberjack_background", ["scripts/skills/perks/perk_legend_specialist_woodaxe_skill"], [{def = ::Const.Perks.PerkDefs.LegendSpecialistWoodaxeSkill, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/manhunter_background", ["scripts/skills/perks/perk_dodge"], [{def = ::Const.Perks.PerkDefs.Dodge, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/mason_background", ["scripts/skills/perks/perk_crPerseverance"], [{def = ::Const.Perks.PerkDefs.crPerseverance, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/messenger_background", ["scripts/skills/perks/perk_lookout"], [{def = ::Const.Perks.PerkDefs.Lookout, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/militia_background", ["scripts/skills/perks/perk_legend_specialist_militia_skill"], [{def = ::Const.Perks.PerkDefs.LegendSpecialistMilitiaSkill, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/miller_background", ["scripts/skills/perks/perk_legend_camp_cook"], [{def = ::Const.Perks.PerkDefs.LegendCampCook, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/miner_background", ["scripts/skills/perks/perk_legend_specialist_pickaxe_skill"], [{def = ::Const.Perks.PerkDefs.LegendSpecialistPickaxeSkill, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/minstrel_background", ["scripts/skills/perks/perk_legend_drums_of_war"], [{def = ::Const.Perks.PerkDefs.LegendDrumsOfWar, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/monk_background", ["scripts/skills/perks/perk_legend_holyflame"], [{def = ::Const.Perks.PerkDefs.LegendHolyFlame, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/legend_nun_background", ["scripts/skills/perks/perk_legend_holyflame"], [{def = ::Const.Perks.PerkDefs.LegendHolyFlame, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/nomad_background", ["scripts/skills/perks/perk_legend_throw_sand"], [{def = ::Const.Perks.PerkDefs.LegendThrowSand, level = 0, optional = false}]);

// Greenskin Invasion Ranger
setupBackground("scripts/skills/backgrounds/orc_slayer_background", ["scripts/skills/perks/perk_legend_favoured_enemy_ork"], [{def = ::Const.Perks.PerkDefs.LegendFavouredEnemyOrk, level = 0, optional = false}]);

// Oathtaker
setupBackground("scripts/skills/backgrounds/paladin_background", ["scripts/skills/perks/perk_battle_forged"], [{def = ::Const.Perks.PerkDefs.BattleForged, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/peddler_background", ["scripts/skills/perks/perk_legend_barter_convincing"], [{def = ::Const.Perks.PerkDefs.LegendBarterConvincing, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/pimp_background", ["scripts/skills/perks/perk_legend_barter_convincing"], [{def = ::Const.Perks.PerkDefs.LegendBarterConvincing, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/poacher_background", ["scripts/skills/perks/perk_lookout"], [{def = ::Const.Perks.PerkDefs.Lookout, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/raider_background", ["scripts/skills/perks/perk_legend_bloodbath"], [{def = ::Const.Perks.PerkDefs.LegendBloodbath, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/ratcatcher_background", ["scripts/skills/perks/perk_legend_net_repair"], [{def = ::Const.Perks.PerkDefs.LegendNetRepair, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/refugee_background", ["scripts/skills/perks/perk_underdog"], [{def = ::Const.Perks.PerkDefs.Underdog, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/regent_in_absentia_background", ["scripts/skills/perks/perk_rotation"], [{def = ::Const.Perks.PerkDefs.Rotation, level = 0, optional = false}, {def = ::Const.Perks.PerkDefs.crFurinkazan, level = 1, optional = false}]);

setupBackground("scripts/skills/backgrounds/retired_soldier_background", ["scripts/skills/perks/perk_legend_back_to_basics"], [{def = ::Const.Perks.PerkDefs.LegendBackToBasics, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/sellsword_background", ["scripts/skills/perks/perk_legend_specialist_shield_skill"], [{def = ::Const.Perks.PerkDefs.LegendSpecialistShieldSkill, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/servant_background", ["scripts/skills/perks/perk_legend_meal_preperation"], [{def = ::Const.Perks.PerkDefs.LegendMealPreperation, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/shepherd_background", ["scripts/skills/perks/perk_legend_specialist_sling_skill"], [{def = ::Const.Perks.PerkDefs.LegendSpecialistSlingSkill, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/slave_background", ["scripts/skills/perks/perk_legend_recuperation"], [{def = ::Const.Perks.PerkDefs.LegendRecuperation, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/squire_background", ["scripts/skills/perks/perk_legend_perfect_fit"], [{def = ::Const.Perks.PerkDefs.LegendPerfectFit, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/swordmaster_background", ["scripts/skills/perks/perk_duelist"], [{def = ::Const.Perks.PerkDefs.Duelist, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/tailor_background", ["scripts/skills/perks/perk_legend_tools_drawers"], [{def = ::Const.Perks.PerkDefs.LegendToolsDrawers, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/thief_background", ["scripts/skills/perks/perk_dodge"], [{def = ::Const.Perks.PerkDefs.Dodge, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/vagabond_background", ["scripts/skills/perks/perk_fast_adaption"], [{def = ::Const.Perks.PerkDefs.FastAdaption, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/wildman_background", ["scripts/skills/perks/perk_legend_gatherer"], [{def = ::Const.Perks.PerkDefs.LegendGatherer, level = 0, optional = false}]);
	
setupBackground("scripts/skills/backgrounds/wildwoman_background", ["scripts/skills/perks/perk_legend_gatherer"], [{def = ::Const.Perks.PerkDefs.LegendGatherer, level = 0, optional = false}]);

setupBackground("scripts/skills/backgrounds/witchhunter_background", ["scripts/skills/perks/perk_legend_favoured_enemy_hexen"], [{def = ::Const.Perks.PerkDefs.LegendFavouredEnemyHexen, level = 0, optional = false}]);