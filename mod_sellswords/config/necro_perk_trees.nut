
// Undead perk groups
::Const.Perks.ZombieClassTree <- {
	ID = "ZombieClassTree",
	Name = "Wiederganger",
	Descriptions = ["eating brains"],
	Tree = [
		[
			::Const.Perks.PerkDefs.ZombieUndying
		],
		[],
		[
			::Const.Perks.PerkDefs.ZombieFeasting
		],
		[
			::Const.Perks.PerkDefs.ZombiePuppet
		],
		[],
		[
			::Const.Perks.PerkDefs.ZombieInfectious
		],
		[
			::Const.Perks.PerkDefs.ZombieFallenHero
		]
	]
};

::Const.Perks.SkeletonClassTree <- {
	ID = "SkeletonClassTree",
	Name = "Ancient Dead",
	Descriptions = ["delivering a boning"],
	Tree = [
		[],
		[],
		[
			::Const.Perks.PerkDefs.SkeletonHarden
		],
		[
			::Const.Perks.PerkDefs.AncientKnowledge
		],
		[],
		[
			::Const.Perks.PerkDefs.SkeletonReconstruction
		],
		[
			::Const.Perks.PerkDefs.Indomitable
		]
	]
};

::Const.Perks.MummyClassTree <- {
	ID = "MummyClassTree",
	Name = "Embalmed",
	Descriptions = ["playing in the sand"],
	Tree = [
		[],
		[],
		[],
		[
			::Const.Perks.PerkDefs.AncientKnowledge
		],
		[
			::Const.Perks.PerkDefs.MummyCursedBody
		],
		[
			::Const.Perks.PerkDefs.MummyInsectBreath
		],
		[
			::Const.Perks.PerkDefs.Indomitable
		]
	]
};

::Const.Perks.GhostClassTree <- {
	ID = "GhostClassTree",
	Name = "Vengeful Spirit",
	Descriptions = ["haunting the living"],
	Tree = [
		[],
		[
			::Const.Perks.PerkDefs.GhostSpectralBody
		],
		[
			::Const.Perks.PerkDefs.GhostPhase
		],
		[
			::Const.Perks.PerkDefs.GhostGhastlyTouch
		],
		[
			::Const.Perks.PerkDefs.GhostVanish
		],
		[],
		[
			::Const.Perks.PerkDefs.GhostSoulEater
		]
	]
};

::Const.Perks.BasicNecroMagicTree.Tree[0] = [::Const.Perks.PerkDefs.LegendRaiseUndead];
::Const.Perks.BasicNecroMagicTree.Tree[1] = [::Const.Perks.PerkDefs.LegendPossession];
::Const.Perks.BasicNecroMagicTree.Tree[2] = [];
::Const.Perks.BasicNecroMagicTree.Tree[3] = [::Const.Perks.PerkDefs.SummonZombieDog];
::Const.Perks.BasicNecroMagicTree.Tree[4] = [::Const.Perks.PerkDefs.LegendChanneledPower];
::Const.Perks.BasicNecroMagicTree.Tree[5] = [::Const.Perks.PerkDefs.SummonZombie,::Const.Perks.PerkDefs.SummonSkeleton];
::Const.Perks.BasicNecroMagicTree.Tree[6] = [::Const.Perks.PerkDefs.LegendExtendendAura];

::Const.Perks.UndeadTrees <- {
	Tree = [
		::Const.Perks.ZombieClassTree,
		::Const.Perks.SkeletonClassTree,
		::Const.Perks.MummyClassTree,
		::Const.Perks.GhostClassTree
	],
};
