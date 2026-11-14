// Blueprint definitions, each blueprint script reads its own with ::Legends.Blueprints.onCreate
::Mod_Sellswords.Blueprint <- {};

// lets a blueprint require a skill that has no Legends definition
::Mod_Sellswords.ScriptRequirement <- {
	function new( _script )
	{
		return ::new(_script);
	}
};

::Legends.Blueprints.addBlueprintDefObjects({
	SsuAcidFlask02 = {
		ID = "blueprint.ssu_acid_flask_02",
		Script = "scripts/crafting/blueprints/ssu_acid_flask_02_blueprint",
		ItemScript = "scripts/items/tools/ssu_acid_flask_item_02",
		Cost = 150,
		Ingredients = [
			{
				Script = "scripts/items/misc/legend_stollwurm_blood_item",
				Num = 1
			}
		],
		Category = ::Legends.Profession.LegendAlchemy
	},
	SsuBanquet = {
		ID = "blueprint.ssu_banquet",
		ItemScript = "scripts/items/supplies/ssu_banquet_item",
		Cost = 150,
		Ingredients = [
			{
				Script = "scripts/items/trade/legend_cooking_spices_trade_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/cured_venison_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/ssu_salad_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/legend_porridge_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/wine_item",
				Num = 1
			}
		],
		Category = ::Legends.Profession.LegendMealPreparation,
		ProfessionRequired = true,
		BlueprintType = "Cooking"
	},
	SsuGainApPotion = {
		ID = "blueprint.ssu_gain_ap_potion",
		Script = "scripts/crafting/blueprints/ssu_gain_ap_potion_blueprint",
		ItemScript = "scripts/items/misc/ssu_ap_potion_item",
		Cost = 5000,
		Ingredients = [
			{
				Script = "scripts/items/special/fountain_of_youth_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/potion_of_knowledge_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/legend_stollwurm_blood_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/kraken_tentacle_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/mysterious_herbs_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/roots_and_berries_item",
				Num = 1
			}
		],
		Category = ::Legends.Profession.LegendAlchemy,
		ProfessionRequired = true
	},
	SsuHornTabard = {
		ID = "blueprint.ssu_horn_tabard",
		Script = "scripts/crafting/blueprints/ssu_horn_tabard_blueprint",
		ItemScript = "scripts/items/legend_armor/tabard/ssu_horn_tabard",
		Cost = 650,
		Ingredients = [
			{
				Script = "scripts/items/misc/kraken_horn_plate_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/ghoul_horn_item",
				Num = 2
			}
		],
		Category = ::Legends.Profession.LegendMetalworking
	},
	SsuHyenaHelmet = {
		ID = "blueprint.ssu_hyena_helmet_layered",
		Script = "scripts/crafting/blueprints/ssu_hyena_helmet_layered_blueprint",
		ItemScript = "scripts/items/legend_helmets/vanity/ssu_hyena_helm",
		Cost = 200,
		Ingredients = [
			{
				Script = "scripts/items/misc/hyena_fur_item",
				Num = 2
			}
		],
		Category = ::Legends.Profession.LegendLeatherworking
	},
	SsuLindwurmHelmet = {
		ID = "blueprint.ssu_lindwurm_helmet_layered_blueprint",
		Script = "scripts/crafting/blueprints/ssu_lindwurm_helmet_layered_blueprint",
		ItemScript = "scripts/items/legend_helmets/helm/ssu_lindwurm_helmet",
		Cost = 1000,
		Ingredients = [
			{
				Script = "scripts/items/misc/lindwurm_scales_item",
				Num = 2
			},
			{
				Script = "scripts/items/legend_helmets/top/legend_helmet_chain_attachment",
				Num = 1
			},
			{
				Script = "scripts/items/legend_helmets/helm/legend_helmet_norman_helm",
				Num = 1
			}
		],
		Category = ::Legends.Profession.LegendMetalworking
	},
	SsuNecroDogBody = {
		ID = "blueprint.ssu_necro_dog_body",
		Script = "scripts/crafting/blueprints/ssu_necro_dog_body_blueprint",
		ItemScript = "scripts/items/spawns/ssu_necro_zombie_dog",
		Cost = 100,
		Ingredients = [
			{
				Script = "scripts/items/accessory/wardog_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/wardog_armor_upgrade_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/strange_meat_item",
				Num = 1
			}
		],
		AlternativeRequirements = [
			[::Legends.Perk.SsuNecroSummonZombieDog, ::Legends.Perks]
		]
	},
	SsuNecroDogBody2 = {
		ID = "blueprint.ssu_necro_dog_body2",
		Script = "scripts/crafting/blueprints/ssu_necro_dog_body_blueprint2",
		ItemScript = "scripts/items/spawns/ssu_necro_zombie_dog",
		Cost = 100,
		Ingredients = [
			{
				Script = "scripts/items/accessory/armored_wardog_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/strange_meat_item",
				Num = 1
			}
		],
		AlternativeRequirements = [
			[::Legends.Perk.SsuNecroSummonZombieDog, ::Legends.Perks]
		]
	},
	SsuNecroHumanBody = {
		ID = "blueprint.ssu_necro_human_body",
		Script = "scripts/crafting/blueprints/ssu_necro_human_body_blueprint",
		ItemScript = "scripts/items/spawns/legend_zombie_item",
		Cost = 150,
		Ingredients = [
			{
				Script = "scripts/items/legend_armor/cloth/legend_armor_quilted_aketon",
				Num = 1
			},
			{
				Script = "scripts/items/legend_helmets/hood/legend_helmet_padded_cap",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/strange_meat_item",
				Num = 1
			}
		],
		AlternativeRequirements = [
			[::Legends.Perk.SsuNecroSummonZombie, ::Legends.Perks]
		]
	},
	SsuNecroHumanBones = {
		ID = "blueprint.ssu_necro_human_bones",
		Script = "scripts/crafting/blueprints/ssu_necro_human_bones_blueprint",
		ItemScript = "scripts/items/spawns/legend_skeleton_item",
		Cost = 150,
		Ingredients = [
			{
				Script = "scripts/items/legend_armor/plate/legend_armor_plate_ancient_chest",
				Num = 1
			},
			{
				Script = "scripts/items/legend_helmets/helm/legend_helmet_ancient_face_plate",
				Num = 1
			}
		],
		AlternativeRequirements = [
			[::Legends.Perk.SsuNecroSummonSkeleton, ::Legends.Perks]
		]
	},
	SsuNecroSkeletonPotion = {
		ID = "blueprint.ssu_necro_skeleton_potion",
		Script = "scripts/crafting/blueprints/ssu_necro_skeleton_potion_blueprint",
		ItemScript = "scripts/items/misc/ssu_necro_skeleton_potion",
		Cost = 100,
		Ingredients = [
			{
				Script = "scripts/items/misc/mysterious_herbs_item",
				Num = 1
			}
		],
		AlternativeRequirements = [
			["scripts/skills/backgrounds/ssu_necro_lorekeeper", ::Mod_Sellswords.ScriptRequirement]
		]
	},
	SsuNecroZombiePotion = {
		ID = "blueprint.ssu_necro_zombie_potion",
		Script = "scripts/crafting/blueprints/ssu_necro_zombie_potion_blueprint",
		ItemScript = "scripts/items/misc/ssu_necro_zombie_potion",
		Cost = 100,
		Ingredients = [
			{
				Script = "scripts/items/misc/mysterious_herbs_item",
				Num = 1
			}
		],
		AlternativeRequirements = [
			["scripts/skills/backgrounds/ssu_necro_lorekeeper", ::Mod_Sellswords.ScriptRequirement]
		]
	},
	SsuSalad = {
		ID = "blueprint.ssu_salad",
		ItemScript = "scripts/items/supplies/ssu_salad_item",
		Cost = 50,
		Ingredients = [
			{
				Script = "scripts/items/trade/legend_cooking_spices_trade_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/dried_fruits_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/dates_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/roots_and_berries_item",
				Num = 1
			}
		],
		Category = ::Legends.Profession.LegendMealPreparation,
		ProfessionRequired = true,
		BlueprintType = "Cooking"
	}
}, ::Mod_Sellswords.Blueprint);
