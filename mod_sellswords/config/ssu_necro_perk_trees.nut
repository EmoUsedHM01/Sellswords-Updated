
// Undead perk groups
::Const.Perks.ZombieClassTree <- {
	ID = "ZombieClassTree",
	Name = ::Mod_Sellswords.Strings.ssu_necro_perk_trees.Name1,
	Descriptions = ::Mod_Sellswords.Strings.ssu_necro_perk_trees.Descriptions1,
	Tree = [
		[
			::Const.Perks.PerkDefs.SsuNecroZombieUndying
		],
		[],
		[
			::Const.Perks.PerkDefs.SsuNecroZombieFeasting
		],
		[
			::Const.Perks.PerkDefs.SsuNecroZombiePuppet
		],
		[],
		[
			::Const.Perks.PerkDefs.SsuNecroZombieInfectious
		],
		[
			::Const.Perks.PerkDefs.SsuNecroZombieFallenHero
		]
	]
};

::Const.Perks.SkeletonClassTree <- {
	ID = "SkeletonClassTree",
	Name = ::Mod_Sellswords.Strings.ssu_necro_perk_trees.Name2,
	Descriptions = ::Mod_Sellswords.Strings.ssu_necro_perk_trees.Descriptions2,
	Tree = [
		[],
		[],
		[
			::Const.Perks.PerkDefs.SsuNecroSkeletonHarden
		],
		[
			::Const.Perks.PerkDefs.SsuNecroAncientKnowledge
		],
		[],
		[
			::Const.Perks.PerkDefs.SsuNecroSkeletonReconstruction
		],
		[
			::Const.Perks.PerkDefs.Indomitable
		]
	]
};

::Const.Perks.MummyClassTree <- {
	ID = "MummyClassTree",
	Name = ::Mod_Sellswords.Strings.ssu_necro_perk_trees.Name3,
	Descriptions = ::Mod_Sellswords.Strings.ssu_necro_perk_trees.Descriptions3,
	Tree = [
		[],
		[],
		[],
		[
			::Const.Perks.PerkDefs.SsuNecroAncientKnowledge
		],
		[
			::Const.Perks.PerkDefs.SsuNecroMummyCursedBody
		],
		[
			::Const.Perks.PerkDefs.SsuNecroMummyInsectBreath
		],
		[
			::Const.Perks.PerkDefs.Indomitable
		]
	]
};

::Const.Perks.GhostClassTree <- {
	ID = "GhostClassTree",
	Name = ::Mod_Sellswords.Strings.ssu_necro_perk_trees.Name4,
	Descriptions = ::Mod_Sellswords.Strings.ssu_necro_perk_trees.Descriptions4,
	Tree = [
		[],
		[
			::Const.Perks.PerkDefs.SsuNecroGhostSpectralBody
		],
		[
			::Const.Perks.PerkDefs.SsuNecroGhostPhase
		],
		[
			::Const.Perks.PerkDefs.SsuNecroGhostGhastlyTouch
		],
		[
			::Const.Perks.PerkDefs.SsuNecroGhostVanish
		],
		[],
		[
			::Const.Perks.PerkDefs.SsuNecroGhostSoulEater
		]
	]
};

// SSU summon perks go into the Legends zombie tree
::Const.Perks.ZombieMagicTree.Tree[3].push(::Const.Perks.PerkDefs.SsuNecroSummonZombieDog);
::Const.Perks.ZombieMagicTree.Tree[5].push(::Const.Perks.PerkDefs.SsuNecroSummonZombie);
::Const.Perks.ZombieMagicTree.Tree[5].push(::Const.Perks.PerkDefs.SsuNecroSummonSkeleton);

::Const.Perks.UndeadTrees <- {
	Tree = [
		::Const.Perks.ZombieClassTree,
		::Const.Perks.SkeletonClassTree,
		::Const.Perks.MummyClassTree,
		::Const.Perks.GhostClassTree
	],
};
