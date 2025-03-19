::mods_hookExactClass("skills/backgrounds/legend_companion_melee_background", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.CustomPerkTree = ::Mod_Sellswords.HookHelper.clearCustomPerkTree(this.m.CustomPerkTree);
		::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
			this.Const.Perks.HeavyArmorTree,
			this.Const.Perks.UnstoppableTree,
			this.Const.Perks.OneHandedTree,
			this.Const.Perks.TwoHandedTree
		]);
		
		::Mod_Sellswords.HookHelper.addPerksToCustomPerkTree(1, this.m.CustomPerkTree, [
			this.Const.Perks.PerkDefs.PTRProfessional,		
		]);		

		if (this.Math.rand(0, 100) <= 50)
		{
			::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
				this.Const.Perks.ShieldTree
			]);
		}

		if (this.Math.rand(0, 100) <= 50)
		{
			::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
				this.Const.Perks.MediumArmorTree
			]);
		}

		local crwptrees = [
			this.Const.Perks.AxeTree,
			this.Const.Perks.CleaverTree,
			this.Const.Perks.FlailTree,
			this.Const.Perks.HammerTree,
			this.Const.Perks.MaceTree,
			this.Const.Perks.SpearTree,
			this.Const.Perks.SwordTree,
			this.Const.Perks.PolearmTree
		];

		for( local i = 0; i < 4; i = ++i )
		{
			::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
				crwptrees.remove(this.Math.rand(0, crwptrees.len() - 1))
			]);
		}

		local crtttrees = [
			this.Const.Perks.LargeTree,
			this.Const.Perks.ResilientTree,
			this.Const.Perks.SturdyTree,
			this.Const.Perks.ViciousTree,
			this.Const.Perks.TalentedTree
		];

		for( local i = 0; i < 3; i = ++i )
		{
			::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
				crtttrees.remove(this.Math.rand(0, crtttrees.len() - 1))
			]);
		}

		local crfetrees = [
			::Const.Perks.SkeletonTree,
			::Const.Perks.ZombieTree,
			::Const.Perks.OrcTree,
			::Const.Perks.OrcTree,
			::Const.Perks.NoblesTree,
			::Const.Perks.NoblesTree,
			::Const.Perks.SouthernersTree,
			::Const.Perks.SouthernersTree,
			::Const.Perks.MercenaryTree,
			::Const.Perks.BanditTree,
			::Const.Perks.NomadsTree,
			::Const.Perks.BarbarianTree,
			::Const.Perks.SwordmastersTree,
			::Const.Perks.SwordmastersTree,
			::Const.Perks.SwordmastersTree,
			::Const.Perks.SwordmastersTree
		];

		for( local i = 0; i < 1; i = ++i )
		{
			::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
				crfetrees.remove(this.Math.rand(0, crfetrees.len() - 1))
			]);
		}

		local crfetrees = [
			this.Const.Perks.BlacksmithProfessionTree,
			this.Const.Perks.LaborerProfessionTree,
			this.Const.Perks.MilitiaProfessionTree,
			this.Const.Perks.RaiderProfessionTree,
			this.Const.Perks.SoldierProfessionTree,
			this.Const.Perks.AssassinProfessionTree,
			this.Const.Perks.NobleProfessionTree,
			this.Const.Perks.BlacksmithProfessionTree,
			this.Const.Perks.LaborerProfessionTree,
			this.Const.Perks.MilitiaProfessionTree,
			this.Const.Perks.RaiderProfessionTree,
			this.Const.Perks.SoldierProfessionTree,
			this.Const.Perks.AssassinProfessionTree,
			this.Const.Perks.NobleProfessionTree,
			this.Const.Perks.JugglerProfessionTree,
			this.Const.Perks.WildlingProfessionTree,
			this.Const.Perks.ButcherProfessionTree,
			this.Const.Perks.LumberjackProfessionTree,
			this.Const.Perks.CultistProfessionTree,
			this.Const.Perks.HolyManProfessionTree,
			this.Const.Perks.MinstrelProfessionTree,
			this.Const.Perks.TraderProfessionTree
		];

		for( local i = 0; i < 1; i = ++i )
		{
			::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
				crfetrees.remove(this.Math.rand(0, crfetrees.len() - 1))
			]);
		}

		if (this.Math.rand(0, 100) <= 50)
		{
			local pr = this.Math.rand(0, 100);

			if (pr <= 35)
			{
				::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
					this.Const.Perks.TrapperClassTree
				]);
			}
			else if (pr <= 65)
			{
				::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
					this.Const.Perks.SergeantClassTree
				]);
			}
			else if (pr <= 85)
			{
				::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
					this.Const.Perks.TacticianClassTree
				]);
			}
			else if (pr <= 100)
			{
				::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
					this.Const.Perks.FistsTree
				]);
			}
		}
	}
	
});