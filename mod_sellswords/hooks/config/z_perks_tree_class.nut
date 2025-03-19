::Const.Perks.VeteranClassTree <- {
	ID = "VeteranClassTree",
	Descriptions = [
		"warfare"
	],
	Name = "Veteran",
	SelfWeightMultiplier = 0.33,
	Tree = [
		[],
		[::Const.Perks.PerkDefs.crAnchor],
		[],
		[],
		[::Const.Perks.PerkDefs.crBlocknormal],
		[],
		[]
	]
};

// adding summon hound to houndmaster tree
::Const.Perks.HoundmasterClassTree.Tree[1] = [::Const.Perks.PerkDefs.LegendSummonHound];

// adding rebalanced punchy mode back to unarmed
::Const.Perks.FistsTree.Tree[6] = [::Const.Perks.PerkDefs.LegendUnarmedTraining];

// Making all the trees appear in alphabetical order because it's nice
::Const.Perks.ClassTrees.Tree.extend([
	::Const.Perks.VeteranClassTree
]);