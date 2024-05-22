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
::Const.Perks.FistsClassTree.Tree[6] = [::Const.Perks.PerkDefs.LegendUnarmedTraining];

// Making all the trees appear in alphabetical order because it's nice
::Const.Perks.ClassTrees.Tree = [
		::Const.Perks.BardClassTree,	
		::Const.Perks.BarterClassTree,	
		::Const.Perks.BeastClassTree,	
		::Const.Perks.ButcherClassTree,	
		::Const.Perks.ChefClassTree,	
		::Const.Perks.FaithClassTree,	
		::Const.Perks.FistsClassTree,	
		::Const.Perks.HammerClassTree,	
		::Const.Perks.HealerClassTree,	
		::Const.Perks.HoundmasterClassTree,
		::Const.Perks.JugglerClassTree,	
		::Const.Perks.KnifeClassTree,	
		::Const.Perks.MilitiaClassTree,	
		::Const.Perks.NinetailsClassTree,	
		::Const.Perks.PickaxeClassTree,	
		::Const.Perks.PitchforkClassTree,	
		::Const.Perks.RepairClassTree,	
		::Const.Perks.ShortbowClassTree,	
		::Const.Perks.SickleClassTree,	
		::Const.Perks.VeteranClassTree,
		::Const.Perks.WoodaxeClassTree
];