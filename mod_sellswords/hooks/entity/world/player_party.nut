::mods_hookExactClass("entity/world/player_party", function ( o )
{
	local updateStrength = o.updateStrength;
	o.updateStrength = function ()
	{
		this.m.Strength = 0.0;
		local roster = this.World.getPlayerRoster().getAll();

		if (roster.len() > this.World.Assets.getBrothersScaleMax())
		{
			roster.sort(this.onLevelCompare);
		}

		if (roster.len() < this.World.Assets.getBrothersScaleMin())
		{
			this.m.Strength += 10.0 * (this.World.Assets.getBrothersScaleMin() - roster.len());
		}

		if (this.World.Assets.getOrigin() == null)
		{
			this.m.Strength * 0.8;
			return;
		}

		local broScale = 1.0;

		if (this.World.Assets.getOrigin().getID() == "scenario.militia")
		{
			broScale = 0.66;
		}

		local zombieSummonLevel = 0;
		local skeletonSummonLevel = 0;
		local count = 0;
		local dc = this.World.getTime().Days;
		local dclevel = 0;

		if (dc <= 120)
		{
			dclevel = this.Math.floor(dc / 12) + 6;
		}

		if (dc > 120)
		{
			dclevel = this.Math.floor(dc / 15) + 8;
		}

		local delevelcount = 0;
		local crattributecount;
		local coreattributecount;

		foreach( i, bro in roster )
		{
			if (i >= 25)
			{
				break;
			}

			if (bro.getSkills().hasSkill("perk.legend_pacifist"))
			{
				continue;
			}

			if (bro.getSkills().hasSkill("perk.legend_spawn_zombie_high"))
			{
				zombieSummonLevel = 7;
			}
			else if (bro.getSkills().hasSkill("perk.legend_spawn_zombie_med"))
			{
				zombieSummonLevel = 5;
			}
			else if (bro.getSkills().hasSkill("perk.legend_spawn_zombie_low"))
			{
				zombieSummonLevel = 2;
			}

			if (bro.getSkills().hasSkill("perk.legend_spawn_skeleton_high"))
			{
				skeletonSummonLevel = 7;
			}
			else if (bro.getSkills().hasSkill("perk.legend_spawn_skeleton_med"))
			{
				skeletonSummonLevel = 5;
			}
			else if (bro.getSkills().hasSkill("perk.legend_spawn_skeleton_low"))
			{
				skeletonSummonLevel = 2;
			}

			local brolevel = bro.getLevel();

			if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Easy)
			{
				this.m.Strength += (3 + (brolevel / 4 + (brolevel - 1)) * 1.5) * broScale;
			}
			else if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Normal)
			{
				this.m.Strength += (10 + (brolevel / 2 + (brolevel - 1)) * 2) * broScale;
			}
			else if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Hard)
			{
				this.m.Strength += (6 + count / 2 + (brolevel / 2 + this.pow(brolevel, 1.2))) * broScale;
			}
			else if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				this.m.Strength += (count + (brolevel + this.pow(brolevel, 1.2))) * broScale;
				delevelcount = this.Math.max(0, brolevel - dclevel);

				if (bro.getSkills().hasSkill("perk.student"))
				{
					delevelcount = delevelcount * 0.9;
				}

				this.m.Strength += this.Math.min(delevelcount + brolevel * this.pow(delevelcount, 1.2) * broScale, 500);
				crattributecount = 1;
				coreattributecount = 1;
				local perkcount = bro.getPerkPointsSpent();

				if (bro.getSkills().hasSkill("perk.student"))
				{
					perkcount = perkcount - 1;
				}

				if (bro.getSkills().hasSkill("perk.ptr_rising_star"))
				{
					perkcount = perkcount - 2;
				}

				if (bro.getSkills().hasSkill("perk.ptr_professional"))
				{
					perkcount = perkcount - 4;
				}

				if (brolevel < 11)
				{
					crattributecount = crattributecount * this.Math.max(1, (bro.getBaseProperties().MeleeSkill - 67 - 3 * brolevel) / 3);
					coreattributecount = coreattributecount * this.Math.max(1, (bro.getBaseProperties().MeleeSkill - 67 - 3 * brolevel) / 3);
					crattributecount = crattributecount * this.Math.max(1, (bro.getBaseProperties().RangedSkill - 55 - 5 * brolevel) / 5);
					crattributecount = crattributecount * this.Math.max(1, (bro.getBaseProperties().MeleeDefense - 17 - 3 * brolevel) / 3);
					coreattributecount = coreattributecount * this.Math.max(1, (bro.getBaseProperties().MeleeDefense - 17 - 3 * brolevel) / 3);
					crattributecount = crattributecount * this.Math.max(1, (bro.getBaseProperties().Stamina - 116 - 4 * brolevel) / 4);
					crattributecount = crattributecount * this.Math.max(1, (bro.getBaseProperties().Hitpoints - 76 - 4 * brolevel) / 4);
					crattributecount = crattributecount * this.Math.max(1, (bro.getBaseProperties().Initiative - 115 - 5 * brolevel) / 5);
					this.m.Strength += this.Math.min(this.pow(crattributecount - 0.9, 0.5), brolevel * 12);
					this.m.Strength += this.Math.min(this.pow(coreattributecount - 0.9, 1.5), 40 + brolevel * 4);
					this.m.Strength += this.Math.min(this.pow(this.Math.max(perkcount - brolevel, 0), 2), brolevel * 10);
				}
				else if (brolevel >= 11)
				{
					crattributecount = crattributecount * this.Math.max(1, (bro.getBaseProperties().MeleeSkill - 90 - brolevel) / 3);
					coreattributecount = coreattributecount * this.Math.max(1, (bro.getBaseProperties().MeleeSkill - 90 - brolevel) / 3);
					crattributecount = crattributecount * this.Math.max(1, (bro.getBaseProperties().RangedSkill - 110 - brolevel) / 5);
					crattributecount = crattributecount * this.Math.max(1, (bro.getBaseProperties().MeleeDefense - 40 - brolevel) / 3);
					coreattributecount = coreattributecount * this.Math.max(1, (bro.getBaseProperties().MeleeDefense - 40 - brolevel) / 3);
					crattributecount = crattributecount * this.Math.max(1, (bro.getBaseProperties().Stamina - 150 - brolevel) / 4);
					crattributecount = crattributecount * this.Math.max(1, (bro.getBaseProperties().Hitpoints - 110 - 4 * brolevel) / 4);
					crattributecount = crattributecount * this.Math.max(1, (bro.getBaseProperties().Initiative - 160 - 5 * brolevel) / 5);
					this.m.Strength += this.Math.min(crattributecount, brolevel * 12);
					this.m.Strength += this.Math.min(this.pow(coreattributecount, 1.5), 40 + brolevel * 4);
					this.m.Strength += this.Math.min(this.pow(this.Math.max(perkcount - brolevel / 3 - 8, 0), 2), brolevel * 15);
				}
			}

			local mainhand = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
			local offhand = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
			local body = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
			local head = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
			local mainhandvalue = 0;
			local offhandvalue = 0;
			local bodyvalue = 0;
			local headvalue = 0;

			if (mainhand != null)
			{
				mainhandvalue = mainhandvalue + mainhand.getValue() / 1000;
			}

			if (offhand != null)
			{
				offhandvalue = offhandvalue + offhand.getValue() / 1000;
			}

			if (body != null)
			{
				bodyvalue = bodyvalue + body.getValue() / 1000;
			}

			if (head != null)
			{
				headvalue = headvalue + head.getValue() / 1000;
			}

			local gearvalue = mainhandvalue + offhandvalue + bodyvalue + headvalue;
			local gearvaluecount = 0.1 * this.pow(dc / 10, 2.4000001) + 2;

			if (this.World.Assets.getOrigin().getID() == "scenario.gladiators" || this.World.Assets.getOrigin().getID() == "scenario.lone_wolf" || this.World.Assets.getOrigin().getID() == "scenario.lone_wolf_easy")
			{
				gearvalue = this.Math.max(gearvalue - 5, 0.5);
			}

			if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
			{
				gearvalue = this.Math.max(gearvalue - 4, 0.5);
			}

			if (this.World.Assets.getOrigin().getID() == "scenario.legends_noble" || this.World.Assets.getOrigin().getID() == "scenario.legends_party" || this.World.Assets.getOrigin().getID() == "scenario.sellswords" || this.World.Assets.getOrigin().getID() == "scenario.trader")
			{
				gearvalue = this.Math.max(gearvalue - 3, 0.5);
			}

			gearvaluecount = this.Math.max(1, gearvalue - gearvaluecount + 1) * this.Math.max(1, gearvalue / gearvaluecount);

			if (gearvaluecount >= 1.2)
			{
				gearvaluecount = gearvaluecount * this.Math.min(this.Math.max(1, 100 / (dc + 15)), 3);
			}

			gearvaluecount = this.Math.min(gearvaluecount, 100);

			if (dc <= 10)
			{
				gearvaluecount = this.Math.min(gearvaluecount, 10);
			}

			if (dc <= 15)
			{
				gearvaluecount = this.Math.min(gearvaluecount, 30);
			}

			this.m.Strength += gearvalue;
			this.m.Strength += gearvaluecount;
			count++;
		}

		if (this.World.Flags.get("CrDifficulty") == 1)
		{
			this.m.Strength *= 0.6;
		}
		else if (this.World.Flags.get("CrDifficulty") == 2)
		{
			this.m.Strength *= 0.75;
		}
		else if (this.World.Flags.get("CrDifficulty") == 3)
		{
			this.m.Strength *= 0.85;
		}
		else if (this.World.Flags.get("CrDifficulty") == 4)
		{
			this.m.Strength *= 1;
		}			
		else if (this.World.Flags.get("CrDifficulty") == 5)
		{
			this.m.Strength *= 1.15;
		}
		else if (this.World.Flags.get("CrDifficulty") == 6)
		{
			this.m.Strength *= 0.4;
		}
		else
		{
			this.m.Strength *= 0.85;
		}			

		if (zombieSummonLevel == 0 && skeletonSummonLevel == 0)
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();
		local zCount = 0;
		local sCount = 0;

		foreach( item in stash )
		{
			if (item == null)
			{
				continue;
			}

			switch(item.getID())
			{
			case "spawns.zombie":
				if (zombieSummonLevel == 0)
				{
					continue;
				}

				zCount = ++zCount;
				zCount = zCount;
				break;

			case "spawns.skeleton":
				if (skeletonSummonLevel == 0)
				{
					continue;
				}

				sCount = ++sCount;
				sCount = sCount;
				break;
			}
		}

		if (zCount > 1)
		{
			zCount = this.Math.floor(zCount / 2.0);

			for( local i = 0; i < zCount; i = i )
			{
				this.m.Strength += 3 + (zombieSummonLevel / 2 + (zombieSummonLevel - 1)) * 2.0;
				i = ++i;
				i = i;
			}
		}

		if (sCount > 1)
		{
			sCount = this.Math.floor(sCount / 2.0);

			for( local i = 0; i < sCount; i = i )
			{
				this.m.Strength += 3 + (skeletonSummonLevel / 2 + (skeletonSummonLevel - 1)) * 2.0;
				i = ++i;
				i = i;
			}
		}
	};
});