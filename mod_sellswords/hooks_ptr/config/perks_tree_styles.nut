// one handed tree
::Const.Perks.OneHandedTree.Tree[2].push(::Const.Perks.PerkDefs.crSignaturemove);

// two handed tree
::Const.Perks.TwoHandedTree.Tree[1].push(::Const.Perks.PerkDefs.QuickHands);
::Const.Perks.TwoHandedTree.Tree[4].push(::Const.Perks.PerkDefs.SunderingStrikes);
::Const.Perks.TwoHandedTree.Tree[6].push(::Const.Perks.PerkDefs.crReachadvantage);

local find = ::Const.Perks.TwoHandedTree.Tree[4].find(::Const.Perks.PerkDefs.ReachAdvantage);
if (find != null) ::Const.Perks.TwoHandedTree.Tree[4].remove(find);

// ranged tree
::Const.Perks.RangedTree.Tree[4].push(::Const.Perks.PerkDefs.PTREyesUp);
::Const.Perks.RangedTree.Tree[6].push(::Const.Perks.PerkDefs.PTRMarksmanship);