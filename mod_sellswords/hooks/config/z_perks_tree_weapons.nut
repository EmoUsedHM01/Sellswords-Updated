// Axe tree
::Const.Perks.AxeTree.Tree[5].push(::Const.Perks.PerkDefs.SsuHackSpm);

// Dagger tree
::Const.Perks.DaggerTree.Tree[4].push(::Const.Perks.PerkDefs.SsuFob);

// Polearm tree, the SSU Reach Advantage takes the place of the vanilla one
::Const.Perks.PolearmTree.Tree[0].push(::Const.Perks.PerkDefs.SsuRetrofithooks);
::Mod_Sellswords.HookHelper.replacePerkInTree(::Const.Perks.PolearmTree, ::Const.Perks.PerkDefs.ReachAdvantage, ::Const.Perks.PerkDefs.SsuReachadvantage);

// Bow tree
::Const.Perks.BowTree.Tree[4].push(::Const.Perks.PerkDefs.SsuParthianshot);
