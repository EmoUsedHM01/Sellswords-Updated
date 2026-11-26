// what the SSU backgrounds bring to the Legends profession tree, each background points its ProfessionTreeBranches at one of these
// Known professions are learned when the bro joins, Roots can be learned from the start, Special ones only by backgrounds that list them

// Sellsword, the same as the Legends Sellsword
::Legends.BackgroundProfessionTrees.SsuSellsword <- {
	CustomProfessionTree = null,
	Profession = {
		FavouredEnemyChance = 2,
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.SsuDryadArcher <- {
	CustomProfessionTree = null,
	Profession = {
		FavouredEnemyChance = 2,
		Roots = [],
		Known = [::Legends.Profession.LegendHunting],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.SsuDryadAvatar <- {
	CustomProfessionTree = null,
	Profession = {
		FavouredEnemyChance = 2,
		Roots = [],
		Known = [::Legends.Profession.LegendGathering, ::Legends.Profession.LegendHerbcraft],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.SsuDryadGrunt <- {
	CustomProfessionTree = null,
	Profession = {
		FavouredEnemyChance = 2,
		Roots = [],
		Known = [::Legends.Profession.LegendGathering],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast]
	}
};

::Legends.BackgroundProfessionTrees.SsuDryadShaman <- {
	CustomProfessionTree = null,
	Profession = {
		FavouredEnemyChance = 2,
		Roots = [::Legends.Profession.LegendForaging],
		Known = [::Legends.Profession.LegendHerbcraft],
		Special = [::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.SsuDryadTamer <- {
	CustomProfessionTree = null,
	Profession = {
		FavouredEnemyChance = 2,
		Roots = [],
		Known = [::Legends.Profession.LegendDogBreeder],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast]
	}
};

::Legends.BackgroundProfessionTrees.SsuDryadWarrior <- {
	CustomProfessionTree = null,
	Profession = {
		FavouredEnemyChance = 2,
		Roots = [],
		Known = [::Legends.Profession.LegendHunting],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

// Ancient Auxiliary, Honour Guard and Legionary, Embalmed Soldier and Fallen Hero
::Legends.BackgroundProfessionTrees.SsuNecroSoldier <- {
	CustomProfessionTree = null,
	Profession = {
		FavouredEnemyChance = 2,
		Roots = [::Legends.Profession.LegendTraining],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

// Embalmed Priest
::Legends.BackgroundProfessionTrees.SsuNecroScholar <- {
	CustomProfessionTree = null,
	Profession = {
		FavouredEnemyChance = 2,
		Roots = [::Legends.Profession.LegendScholar],
		Known = [],
		Special = [::Legends.Profession.LegendAncientKnowledge, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.SsuNecroLorekeeper <- {
	CustomProfessionTree = null,
	Profession = {
		FavouredEnemyChance = 2,
		Roots = [],
		Known = [::Legends.Profession.LegendScholar],
		Special = [::Legends.Profession.LegendAncientKnowledge, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.SsuNecroNecrosavant <- {
	CustomProfessionTree = null,
	Profession = {
		FavouredEnemyChance = 2,
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendAncientKnowledge, ::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

// Embalmed Slave
::Legends.BackgroundProfessionTrees.SsuNecroSlave <- {
	CustomProfessionTree = null,
	Profession = {
		FavouredEnemyChance = 2,
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

// Banshee and Ghost
::Legends.BackgroundProfessionTrees.SsuNecroSpirit <- {
	CustomProfessionTree = null,
	Profession = {
		FavouredEnemyChance = 2,
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

// Zombie and Skeledog, nothing of their own
::Legends.BackgroundProfessionTrees.SsuNecroBeast <- {
	CustomProfessionTree = null,
	Profession = {
		FavouredEnemyChance = 2,
		Roots = [],
		Known = [],
		Special = []
	}
};
