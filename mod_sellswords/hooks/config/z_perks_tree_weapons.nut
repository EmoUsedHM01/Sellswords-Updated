// Axe tree
::Const.Perks.AxeTree.Tree[5].push(::Const.Perks.PerkDefs.SsuHackSpm);

// Dagger tree
::Const.Perks.DaggerTree.Tree[4].push(::Const.Perks.PerkDefs.SsuFob);

// Polearm tree, the SSU Reach Advantage takes the place of the vanilla one
::Const.Perks.PolearmTree.Tree[0].push(::Const.Perks.PerkDefs.SsuRetrofithooks);
::Mod_Sellswords.HookHelper.replacePerkInTree(::Const.Perks.PolearmTree, ::Const.Perks.PerkDefs.ReachAdvantage, ::Const.Perks.PerkDefs.SsuReachadvantage);
// Assistance in row 7 takes the place of Push the Advantage in row 5
local row = ::Const.Perks.PolearmTree.Tree[4];
local index = row.find(::Const.Perks.PerkDefs.LegendPushTheAdvantage);

if (index != null)
	row.remove(index);

::Const.Perks.PolearmTree.Tree[6].push(::Const.Perks.PerkDefs.SsuAssistance);

// Bow tree
::Const.Perks.BowTree.Tree[2].push(::Const.Perks.PerkDefs.SsuParthianshot);
