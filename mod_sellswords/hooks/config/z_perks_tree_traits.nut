// Going to comment out all the places that the base Legends perks are just so I know what is where and where to put perks, will edit as legends changes trees

// Agile tree
//::Const.Perks.AgileTree.Tree[0] = [::Const.Perks.PerkDefs.Pathfinder];
::Const.Perks.AgileTree.Tree[1] = [::Const.Perks.PerkDefs.crBackswing]; // No swap
//::Const.Perks.AgileTree.Tree[2] = [];
//::Const.Perks.AgileTree.Tree[3] = [::Const.Perks.PerkDefs.LegendAthlete];
//::Const.Perks.AgileTree.Tree[4] = [::Const.Perks.PerkDefs.Footwork];
::Const.Perks.AgileTree.Tree[5] = [::Const.Perks.PerkDefs.BattleFlow]; // No swap
//::Const.Perks.AgileTree.Tree[6] = [];

// Calm tree
//::Const.Perks.CalmTree.Tree[0] = [::Const.Perks.PerkDefs.LegendAlert];
::Const.Perks.CalmTree.Tree[1] = [::Const.Perks.PerkDefs.LegendTrueBeliever]; // No swap
//::Const.Perks.CalmTree.Tree[2] = [];
//::Const.Perks.CalmTree.Tree[3] = [::Const.Perks.PerkDefs.LegendPeaceful];
::Const.Perks.CalmTree.Tree[4] = [::Const.Perks.PerkDefs.crClarity]; // Swaps out base LegendClarity
//::Const.Perks.CalmTree.Tree[5] = [];
//::Const.Perks.CalmTree.Tree[6] = [::Const.Perks.PerkDefs.PerfectFocus];

// Devious tree
::Const.Perks.DeviousTree.Tree[0] = [::Const.Perks.PerkDefs.LegendBlendIn]; // Swaps LegendTrueBeliever
::Const.Perks.DeviousTree.Tree[1] = [::Const.Perks.PerkDefs.LegendThrowSand]; // No swap
::Const.Perks.DeviousTree.Tree[2] = [::Const.Perks.PerkDefs.LegendEvasion]; // Swaps LegendBlendIn
//::Const.Perks.DeviousTree.Tree[3] = [];
::Const.Perks.DeviousTree.Tree[4] = []; // Swaps LegendEvasion
::Const.Perks.DeviousTree.Tree[5] = [::Const.Perks.PerkDefs.LegendDoubleStrike, ::Const.Perks.PerkDefs.Backstabber]; // No swap
::Const.Perks.DeviousTree.Tree[6] = [::Const.Perks.PerkDefs.LegendMindOverBody]; // No swap

// Fast tree
//::Const.Perks.FastTree.Tree[0] = [::Const.Perks.PerkDefs.FastAdaption,::Const.Perks.PerkDefs.Adrenaline];
//::Const.Perks.FastTree.Tree[1] = [::Const.Perks.PerkDefs.Anticipation,::Const.Perks.PerkDefs.LegendQuickStep];
//::Const.Perks.FastTree.Tree[2] = [];
//::Const.Perks.FastTree.Tree[3] = [];
::Const.Perks.FastTree.Tree[4] = [::Const.Perks.PerkDefs.crNavigator]; // No swap
//::Const.Perks.FastTree.Tree[5] = []
//::Const.Perks.FastTree.Tree[6] = [];

// Fit tree
//::Const.Perks.FitTree.Tree[0] = [::Const.Perks.PerkDefs.Recover];
//::Const.Perks.FitTree.Tree[1] = [];
//::Const.Perks.FitTree.Tree[2] = [];
//::Const.Perks.FitTree.Tree[3] = [];
::Const.Perks.FitTree.Tree[4] = [::Const.Perks.PerkDefs.LegendRebound]; // No swap
::Const.Perks.FitTree.Tree[5] = [::Const.Perks.PerkDefs.crbeforethestorm]; // Swaps Overwhelm
::Const.Perks.FitTree.Tree[6] = [::Const.Perks.PerkDefs.Overwhelm]; // Swaps Rebound

// Indestructible tree
//::Const.Perks.IndestructibleTree.Tree[0] = [::Const.Perks.PerkDefs.NineLives];
//::Const.Perks.IndestructibleTree.Tree[1] = [];
::Const.Perks.IndestructibleTree.Tree[2] = [::Const.Perks.PerkDefs.crresilient]; // Swaps HoldOut
//::Const.Perks.IndestructibleTree.Tree[3] = [];
::Const.Perks.IndestructibleTree.Tree[4] = [::Const.Perks.PerkDefs.LoneWolf]; // No swap
::Const.Perks.IndestructibleTree.Tree[5] = [::Const.Perks.PerkDefs.crPerseverance];
//::Const.Perks.IndestructibleTree.Tree[6] = [::Const.Perks.PerkDefs.Indomitable];

// Inspirational tree, this gets removed if PTR exists
//::Const.Perks.InspirationalTree.Tree[0] = [];
//::Const.Perks.InspirationalTree.Tree[1] = [::Const.Perks.PerkDefs.RallyTheTroops];
//::Const.Perks.InspirationalTree.Tree[2] = [::Const.Perks.PerkDefs.Taunt];
//::Const.Perks.InspirationalTree.Tree[3] = [];
//::Const.Perks.InspirationalTree.Tree[4] = [];
//::Const.Perks.InspirationalTree.Tree[5] = [::Const.Perks.PerkDefs.InspiringPresence];
//::Const.Perks.InspirationalTree.Tree[6] = [::Const.Perks.PerkDefs.Inspire];

// Intelligent tree
//::Const.Perks.IntelligentTree.Tree[0] = [::Const.Perks.PerkDefs.Student];
//::Const.Perks.IntelligentTree.Tree[1] = [::Const.Perks.PerkDefs.Gifted];
//::Const.Perks.IntelligentTree.Tree[2] = [];
//::Const.Perks.IntelligentTree.Tree[3] = [];
//::Const.Perks.IntelligentTree.Tree[4] = [::Const.Perks.PerkDefs.LegendAdaptive];
::Const.Perks.IntelligentTree.Tree[5] = [::Const.Perks.PerkDefs.LegendAssuredConquest]; // Swaps LegendMindOverBody
//::Const.Perks.IntelligentTree.Tree[6] = [];

// large tree
//::Const.Perks.LargeTree.Tree[0] = [::Const.Perks.PerkDefs.Colossus];
//::Const.Perks.LargeTree.Tree[1] = [];
::Const.Perks.LargeTree.Tree[2] = [::Const.Perks.PerkDefs.crAudaciouscharge]; // No swap
//::Const.Perks.LargeTree.Tree[3] = [];
::Const.Perks.LargeTree.Tree[4] = [::Const.Perks.PerkDefs.LegendMuscularity]; // Swaps LegendSecondWind
//::Const.Perks.LargeTree.Tree[5] = [];
::Const.Perks.LargeTree.Tree[6] = [::Const.Perks.PerkDefs.crGrandslam]; // Swaps LegendMuscularity

// Martyr tree, this gets removed if PTR exists
//::Const.Perks.MartyrTree.Tree[0] = [];
::Const.Perks.MartyrTree.Tree[1] = [::Const.Perks.PerkDefs.crTiC]; // No swap
//::Const.Perks.MartyrTree.Tree[2] = [];
::Const.Perks.MartyrTree.Tree[3] = [::Const.Perks.PerkDefs.LegendVengeance]; // No swap
::Const.Perks.MartyrTree.Tree[4] = [::Const.Perks.PerkDefs.LegendSecondWind]; // Swaps LoneWolf
::Const.Perks.MartyrTree.Tree[5] = [::Const.Perks.PerkDefs.Fearsome]; // Swaps Vengeance
//::Const.Perks.MartyrTree.Tree[6] = [::Const.Perks.PerkDefs.LegendLastStand];

// Organised tree
//::Const.Perks.OrganisedTree.Tree[0] = [::Const.Perks.PerkDefs.BagsAndBelts, ::Const.Perks.PerkDefs.LegendPacifist];
//::Const.Perks.OrganisedTree.Tree[1] = [::Const.Perks.PerkDefs.LegendHelpful];
//::Const.Perks.OrganisedTree.Tree[2] = [::Const.Perks.PerkDefs.LegendEfficientPacking];
//::Const.Perks.OrganisedTree.Tree[3] = [];
//::Const.Perks.OrganisedTree.Tree[4] = [::Const.Perks.PerkDefs.LegendSkillfulStacking];
//::Const.Perks.OrganisedTree.Tree[5] = [];
//::Const.Perks.OrganisedTree.Tree[6] = [];

// Sturdy tree
//::Const.Perks.SturdyTree.Tree[0] = [::Const.Perks.PerkDefs.LegendRecuperation];
//::Const.Perks.SturdyTree.Tree[1] = [::Const.Perks.PerkDefs.FortifiedMind];
//::Const.Perks.SturdyTree.Tree[2] = [::Const.Perks.PerkDefs.Steadfast];
//::Const.Perks.SturdyTree.Tree[3] = [];
::Const.Perks.SturdyTree.Tree[4] = [::Const.Perks.PerkDefs.SteelBrow]; // No swap
//::Const.Perks.SturdyTree.Tree[5] = [];
//::Const.Perks.SturdyTree.Tree[6] = [];

// Trained tree
//::Const.Perks.TrainedTree.Tree[0] = [::Const.Perks.PerkDefs.LegendBackToBasics];
// ::Const.Perks.TrainedTree.Tree[1] = [::Const.Perks.PerkDefs.crAnchor]; // No swap
//::Const.Perks.TrainedTree.Tree[2] = [::Const.Perks.PerkDefs.Rotation];
//::Const.Perks.TrainedTree.Tree[3] = [];
//::Const.Perks.TrainedTree.Tree[4] = [::Const.Perks.PerkDefs.Underdog];
::Const.Perks.TrainedTree.Tree[5] = [::Const.Perks.PerkDefs.crBattlerhaposdy]; // No swap
//::Const.Perks.TrainedTree.Tree[6] = [];

// Vicious tree
//::Const.Perks.ViciousTree.Tree[0] = [::Const.Perks.PerkDefs.CripplingStrikes];
::Const.Perks.ViciousTree.Tree[1] = [::Const.Perks.PerkDefs.LegendDebilitate]; // No swap
::Const.Perks.ViciousTree.Tree[2] = [::Const.Perks.PerkDefs.CoupDeGrace]; // Swaps Debilitate
//::Const.Perks.ViciousTree.Tree[3] = [];
::Const.Perks.ViciousTree.Tree[4] = []; // Swaps Berserk
::Const.Perks.ViciousTree.Tree[5] = [::Const.Perks.PerkDefs.Berserk]; // Swaps LegendAssuredConquest
::Const.Perks.ViciousTree.Tree[6] = [::Const.Perks.PerkDefs.KillingFrenzy]; // No swap

// Making all the trees appear in alphabetical order because it's nice
::Const.Perks.TraitsTrees.Tree = [
		::Const.Perks.AgileTree,	
		::Const.Perks.CalmTree,	
		::Const.Perks.DeviousTree,
		::Const.Perks.FastTree,	
		::Const.Perks.FitTree,	
		::Const.Perks.IndestructibleTree,	
		::Const.Perks.InspirationalTree,	
		::Const.Perks.IntelligentTree,	
		::Const.Perks.LargeTree,	
		::Const.Perks.MartyrTree,	
		::Const.Perks.OrganisedTree,	
		::Const.Perks.SturdyTree,	
		::Const.Perks.TrainedTree,	
		::Const.Perks.ViciousTree
];

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