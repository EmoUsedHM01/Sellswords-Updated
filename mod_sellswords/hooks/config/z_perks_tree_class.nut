::Const.Perks.VeteranClassTree <- {
	ID = "VeteranClassTree",
	Descriptions = [
		"warfare"
	],
	Name = ::Mod_Sellswords.Strings.z_perks_tree_class.Name,
	SelfWeightMultiplier = 0.33,
	Tree = [
		[],
		[],
		[],
		[],
		[::Const.Perks.PerkDefs.SsuBlocknormal],
		[],
		[]
	]
};

// adding summon hound to houndmaster tree
::Const.Perks.HoundmasterClassTree.Tree[1].push(::Const.Perks.PerkDefs.LegendSummonHound);

// adding rebalanced punchy mode back to unarmed
::Const.Perks.BeastClassTree.Tree[4].push(::Const.Perks.PerkDefs.LegendEscapeArtist);

// Making all the trees appear in alphabetical order because it's nice
::Const.Perks.ClassTrees.Tree.extend([
	::Const.Perks.VeteranClassTree
]);