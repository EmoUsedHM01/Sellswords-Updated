::Const.Perks.DryadShamanTree <- {
	ID = "DryadShamanTree",
	Descriptions = [
		"healing the soul"
	],
	Name = "Dryad Shaman",
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

::Const.Perks.DryadTamerTree <- {
	ID = "DryadTamerTree",
	Descriptions = [
		"taming wildlife"
	],
	Name = "Dryad Tamer",
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

::Const.Perks.MagicTrees.Tree.extend([
	::Const.Perks.DryadShamanTree,
	::Const.Perks.DryadTamerTree
]);