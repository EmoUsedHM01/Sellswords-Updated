::mods_hookExactClass("skills/perks/perk_ptr_promised_potential", function ( o )
{
	o.m.StatBoost = 5;
	o.m.ChanceToSucceed = 100;

	o.onUpdateLevel = function()
	{
		local actor = this.getContainer().getActor();
		if (actor.m.Level == 11 || actor.m.Level == 7 && this.World.Assets.getOrigin().getID() == "scenario.manhunters" && this.getBackground().getID() == "background.slave")
		{
			if (!this.m.IsSpent)
			{
				this.m.IsSpent = true;

				if (this.m.WillSucceed)
				{
					++actor.m.PerkPoints;

					local bg = actor.getBackground();
					local b = actor.getBaseProperties();

					b.DailyWageMult *= 2;
					local r;
					r = this.Math.rand(0, 5);
					b.MeleeSkill += this.m.StatBoost + r;
					r = this.Math.rand(0, 5);					
					b.MeleeDefense += this.m.StatBoost + r;
					r = this.Math.rand(0, 5);					
					b.RangedSkill += this.m.StatBoost + r;
					r = this.Math.rand(0, 5);					
					b.RangedDefense += this.m.StatBoost + r;
					r = this.Math.rand(0, 5);					
					b.Hitpoints += this.m.StatBoost + r;
					r = this.Math.rand(0, 5);					
					b.Stamina += this.m.StatBoost + r;
					r = this.Math.rand(0, 5);					
					b.Initiative += this.m.StatBoost + r;
					r = this.Math.rand(0, 5);					
					b.Bravery += this.m.StatBoost + r;
					
					bg.m.Description += " Once a dreg of society, with your help, " + actor.getNameOnly() + " has grown into a full-fledged mercenary.";
					bg.m.RawDescription += " Once a dreg of society, with your help, %name% has grown into a full-fledged mercenary.";

					local getExclude = function( _treeList )
					{
						local exclude = [];
						//added by bigmap
						if(bg.m.CustomPerkTreeMap == null)
						{
							return exclude;
						}
						foreach (tree in _treeList)
						{
							foreach (category in bg.m.CustomPerkTreeMap)
							{
								foreach (treeInMap in category)
								{
									if (treeInMap.ID == tree.ID)
									{
										exclude.push(tree.ID);
									}
								}
							}
						}

						return exclude;
					}

					local traitsExclude = getExclude(this.Const.Perks.TraitsTrees.Tree);			
					traitsExclude.push(this.Const.Perks.TalentedTree.ID);
					local traitTree = ::MSU.Array.rand(::Const.Perks.TraitsTrees.Tree.filter(@(idx, tree) traitsExclude.find(tree.ID) == null));
					if (traitTree != null)
					{
						bg.addPerkGroup(traitTree.Tree);
					}

					local weaponExclude = getExclude(this.Const.Perks.WeaponTrees.Tree);	
					local weaponTree = ::MSU.Array.rand(::Const.Perks.WeaponTrees.Tree.filter(@(idx, tree) weaponExclude.find(tree.ID) == null));
					if (weaponTree != null)
					{
						bg.addPerkGroup(weaponTree.Tree);
					}

					local perksToRemove = [];
					foreach (row in bg.m.CustomPerkTree)
					{
						for (local i = row.len() - 1; i > 14; i--)
						{
							perksToRemove.push(row[i]);
						}
					}

					foreach (perk in perksToRemove)
					{
						bg.removePerk(perk);
					}

					local row = 0;
					foreach (perk in perksToRemove)
					{
						while (row < 7)
						{
							if (bg.m.CustomPerkTree[row].len() < 15)
							{
								bg.addPerk(perk, row);
								break;
							}
							else
							{
								row++;
							}
						}
					}

					actor.resetPerks();

					actor.improveMood(1.0, "Realized potential");
				}
				else
				{
					this.updatePerkVisuals();
				}
			}
		}
	}
	
	o.onAdded = function()
	{
		if (this.m.IsSet || !this.getContainer().getActor().isPlayerControlled())
		{
			return;
		}

		local actor = this.getContainer().getActor();

		if (this.Math.rand(1, 100) >= this.m.ChanceToSucceed - (this.getContainer().getActor().getPerkPointsSpent() * 100))
		{
			this.m.WillSucceed = false;
		}

		this.m.IsSet = true;
	}

});