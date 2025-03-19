// assassin tree
::Const.Perks.AssassinProfessionTree.Tree[6].push(::Const.Perks.PerkDefs.LegendUntouchable);

local find = ::Const.Perks.AssassinProfessionTree.Tree[6].find(::Const.Perks.PerkDefs.LegendAssassinate);
if (find != null) ::Const.Perks.AssassinProfessionTree.Tree[6].remove(find);

// add new profession trees
::Const.Perks.KnightProfessionTree <- {
	ID = "KnightProfessionTree",
	Descriptions = [
		"fights bravely and displays military professionalism and courtesy",
		"has the values of gentility, nobility and treats others reasonably",
		"protects the weak and defenseless for honor"
	],
	Name = "Chivalric Knight",
	PerkGroupMultipliers = [
	],
	Tree = [
		[::Const.Perks.PerkDefs.Colossus],
		[],
		[::Const.Perks.PerkDefs.crHonorheritage],
		[],
		[],
		[::Const.Perks.PerkDefs.PTRPersonalArmor],
		[::Const.Perks.PerkDefs.PTRUnstoppable]
	]
};

::Const.Perks.RaiderProfessionTree <- {
	ID = "RaiderProfessionTree",
	Descriptions = [
		"raided villages and caravans",
		"is a well-known raider and looter in this area"
	],
	Name = "Raider",
	PerkGroupMultipliers = [
		[2, ::Const.Perks.CaravanTree],
		[2, ::Const.Perks.NoblesTree],
		[3, ::Const.Perks.ViciousTree],
		[0.25, ::Const.Perks.CalmTree]
	],
	Tree = [
		[
			::Const.Perks.PerkDefs.LegendThrowSand //added throw sand to the tree
		],
		[],
		[
			::Const.Perks.PerkDefs.PTRMenacing
		],
		[],
		[],
		[
			::Const.Perks.PerkDefs.PTRBully
		],
		[]
	]
};

::Const.Perks.ProfessionTrees.Tree = [
	::Const.Perks.ApothecaryProfessionTree,	
	::Const.Perks.AssassinProfessionTree,	
	::Const.Perks.BlacksmithProfessionTree,	
	::Const.Perks.ButcherProfessionTree,	
	::Const.Perks.CultistProfessionTree,	
	::Const.Perks.DiggerProfessionTree,	
	::Const.Perks.FarmerProfessionTree,	
	::Const.Perks.FistsTree,
	::Const.Perks.HolyManProfessionTree,	
	::Const.Perks.HunterProfessionTree,	
	::Const.Perks.JugglerProfessionTree,
	::Const.Perks.KnightProfessionTree,		//added from above
	::Const.Perks.LaborerProfessionTree,	
	::Const.Perks.LumberjackProfessionTree,	
	::Const.Perks.MilitiaProfessionTree,	
	::Const.Perks.MinerProfessionTree,	
	::Const.Perks.MinstrelProfessionTree,	
	::Const.Perks.NobleProfessionTree,	
	::Const.Perks.PauperProfessionTree,	
	::Const.Perks.RaiderProfessionTree,	
	::Const.Perks.ServiceProfessionTree,	
	::Const.Perks.SoldierProfessionTree,	
	::Const.Perks.SwordmasterProfessionTree,	
	::Const.Perks.TraderProfessionTree,	
	::Const.Perks.WildlingProfessionTree
];