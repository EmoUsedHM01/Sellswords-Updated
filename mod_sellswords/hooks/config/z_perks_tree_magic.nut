::Const.Perks.DryadShamanTree <- {
	ID = "DryadShamanTree",
	Descriptions = [
		"healing the soul"
	],
	Name = "Dryad Shaman",
	Tree = [
		[],
		[::Const.Perks.PerkDefs.DryadSummonWolf],
		[::Const.Perks.PerkDefs.DryadSummonSnake],
		[],
		[],
		[],
		[::Const.Perks.PerkDefs.DryadSummonUnhold]
	]
};

::Const.Perks.DryadTamerTree <- {
	ID = "DryadTamerTree",
	Descriptions = [
		"taming wildlife"
	],
	Name = "Dryad Tamer",
	Tree = [
		[::Const.Perks.PerkDefs.LegendWither],
		[::Const.Perks.PerkDefs.LegendRoots],
		[::Const.Perks.PerkDefs.DryadForestBlessing],
		[],
		[::Const.Perks.PerkDefs.LegendInsects, ::Const.Perks.PerkDefs.DryadNaturalRegrowth],
		[],
		[]
	]
};

// Making all the trees appear in alphabetical order because it's nice
::Const.Perks.MagicTrees.Tree = [
	::Const.Perks.AssassinMagicTree,
	::Const.Perks.BasicNecroMagicTree,
	::Const.Perks.BerserkerMagicTree,
	::Const.Perks.CaptainMagicTree,
	::Const.Perks.ConjurationMagicTree,
	::Const.Perks.DruidMagicTree,
	::Const.Perks.DryadShamanTree,
	::Const.Perks.DryadTamerTree,
	::Const.Perks.EvocationMagicTree,
	::Const.Perks.IllusionistMagicTree,
	::Const.Perks.PhilosophyMagicTree,
	::Const.Perks.RangerHuntMagicTree,
	::Const.Perks.SkeletonMagicTree,
	::Const.Perks.TransmutationMagicTree,
	::Const.Perks.ValaChantMagicTree,
	::Const.Perks.ValaTranceMagicTree,
	::Const.Perks.VampireMagicTree,
	::Const.Perks.WarlockMagicTree,
	::Const.Perks.ZombieMagicTree
];