::Const.Perks.DryadShamanTree <- {
	ID = "DryadShamanTree",
	Descriptions = [
		"healing the soul"
	],
	Name = ::Mod_Sellswords.Strings.z_perks_tree_magic.Name1,
	Tree = [
		[::Const.Perks.PerkDefs.LegendWither],
		[::Const.Perks.PerkDefs.LegendRoots],
		[::Const.Perks.PerkDefs.SsuDryadForestBlessing],
		[],
		[::Const.Perks.PerkDefs.LegendInsectSwarm, ::Const.Perks.PerkDefs.SsuDryadNaturalRegrowth],
		[],
		[]
	]
};

::Const.Perks.DryadTamerTree <- {
	ID = "DryadTamerTree",
	Descriptions = [
		"taming wildlife"
	],
	Name = ::Mod_Sellswords.Strings.z_perks_tree_magic.Name2,
	Tree = [
		[],
		[::Const.Perks.PerkDefs.SsuDryadSummonWolf],
		[::Const.Perks.PerkDefs.SsuDryadSummonSnake],
		[],
		[],
		[],
		[::Const.Perks.PerkDefs.SsuDryadSummonUnhold]
	]
};

::Const.Perks.MagicTrees.Tree.extend([
	::Const.Perks.DryadShamanTree,
	::Const.Perks.DryadTamerTree
]);