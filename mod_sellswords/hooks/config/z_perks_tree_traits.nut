// SSU perks are pushed into the Legends trees, the Legends perks stay wherever Legends puts them

// Agile tree
::Const.Perks.AgileTree.Tree[1].push(::Const.Perks.PerkDefs.SsuBackswing);

// Calm tree
::Const.Perks.CalmTree.Tree[1].push(::Const.Perks.PerkDefs.SsuClarity);

// Fast tree
::Const.Perks.FastTree.Tree[4].push(::Const.Perks.PerkDefs.SsuNavigator);

// Fit tree, Patient Hunter is the Legends perk
::Const.Perks.FitTree.Tree[5].push(::Const.Perks.PerkDefs.LegendPatientHunter);

// Indestructible tree
::Const.Perks.IndestructibleTree.Tree[5].push(::Const.Perks.PerkDefs.SsuPerseverance);

// Large tree
::Const.Perks.LargeTree.Tree[2].push(::Const.Perks.PerkDefs.SsuAudaciouscharge);
::Const.Perks.LargeTree.Tree[6].push(::Const.Perks.PerkDefs.SsuGrandslam);

// Martyr tree
::Const.Perks.MartyrTree.Tree[1].push(::Const.Perks.PerkDefs.SsuTic);

// Trained tree
::Const.Perks.TrainedTree.Tree[5].push(::Const.Perks.PerkDefs.SsuBattlerhaposdy);

// Making all the trees appear in alphabetical order because it's nice
::Const.Perks.TraitsTrees.Tree.sort(@( _a, _b ) _a.ID <=> _b.ID);

::Const.Perks.TraitsTrees.getBaseAttributes = function(){
	// Overiding the base penalties from Legends which affects all trees
	return {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	};
};