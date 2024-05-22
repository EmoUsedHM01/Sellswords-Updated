::mods_hookExactClass("skills/backgrounds/legend_companion_ranged_background", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		
		this.m.CustomPerkTree = ::Mod_Sellswords.HookHelper.clearCustomPerkTree(this.m.CustomPerkTree);
		::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
			this.Const.Perks.LightArmorTree,
			this.Const.Perks.UnstoppableTree,
			this.Const.Perks.OneHandedTree,
			this.Const.Perks.RangedTree
		]);

		if (this.Math.rand(0, 100) <= 33)
		{
			::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
				this.Const.Perks.MediumArmorTree
			]);
		}

		local crwptrees = [
			::Const.Perks.BowTree,
			::Const.Perks.CrossbowTree,
			::Const.Perks.SlingTree,
			::Const.Perks.ThrowingTree
		];

		for( local i = 0; i < 2; i = ++i )
		{
			::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
				crwptrees.remove(this.Math.rand(0, crwptrees.len() - 1))
			]);
		}

		local crwptrees = [
			this.Const.Perks.AxeTree,
			this.Const.Perks.StaffTree,
			this.Const.Perks.CleaverTree,
			this.Const.Perks.DaggerTree,
			this.Const.Perks.SpearTree,
			this.Const.Perks.SwordTree
		];

		for( local i = 0; i < 2; i = ++i )
		{
			::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
				crwptrees.remove(this.Math.rand(0, crwptrees.len() - 1))
			]);
		}

		local crtttrees = [
			this.Const.Perks.AgileTree,
			this.Const.Perks.CalmTree,
			this.Const.Perks.FastTree,
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
			::Const.Perks.GoblinTree,
			::Const.Perks.GoblinTree,
			::Const.Perks.NoblesTree,
			::Const.Perks.NoblesTree,
			::Const.Perks.SouthernersTree,
			::Const.Perks.SouthernersTree,
			::Const.Perks.MercenaryTree,
			::Const.Perks.BanditTree,
			::Const.Perks.NomadsTree,
			::Const.Perks.BarbarianTree,
			::Const.Perks.ArchersTree,
			::Const.Perks.ArchersTree,
			::Const.Perks.ArchersTree,
			::Const.Perks.ArchersTree
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

			if (pr <= 30)
			{
				::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
					this.Const.Perks.TrapperClassTree
				]);
			}
			else if (pr <= 50)
			{
				::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
					this.Const.Perks.TacticianClassTree
				]);
			}
			else if (pr <= 60)
			{
				::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
					this.Const.Perks.HealerClassTree
				]);
			}
			else if (pr <= 70)
			{
				::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
					this.Const.Perks.ChefClassTree
				]);
			}
			else if (pr <= 80)
			{
				::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
					this.Const.Perks.MenderClassTree
				]);
			}
			else if (pr <= 90)
			{
				::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
					this.Const.Perks.HoundmasterClassTree
				]);
			}
			else if (pr <= 100)
			{
				::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
					this.Const.Perks.ClerkClassTree
				]);
			}
		}
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				5,
				5
			],
			Bravery = [
				8,
				5
			],
			Stamina = [
				10,
				5
			],
			MeleeSkill = [
				8,
				8
			],
			RangedSkill = [
				18,
				13
			],
			MeleeDefense = [
				-3,
				0
			],
			RangedDefense = [
				7,
				5
			],
			Initiative = [
				10,
				5
			]
		};
		return c;
	};
});