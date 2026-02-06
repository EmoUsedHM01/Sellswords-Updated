::Const.Perks.VeteranClassTree <- {
	ID = "VeteranClassTree",
	Descriptions = [
		"warfare"
	],
	Name = "Veteran",
	SelfWeightMultiplier = 0.33,
	Tree = [
		[],
		[], // ::Const.Perks.PerkDefs.crAnchor
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
::Const.Perks.BeastClassTree.Tree[4] = [::Const.Perks.PerkDefs.LegendEscapeArtist];

// adding freedom of movement to juggler tree
::Const.Perks.JugglerClassTree.Tree[6] = [::Const.Perks.PerkDefs.LegendFreedomOfMovement];

// Making all the trees appear in alphabetical order because it's nice
::Const.Perks.ClassTrees.Tree.extend([
	::Const.Perks.VeteranClassTree
]);