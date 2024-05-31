::Mod_Sellswords.HooksMod.hook("scripts/items/misc/anatomist/research_notes_undead_item", function ( q )  {

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		foreach (buff in [
			{
				flag = "isCrFallenBetrayerPotionDiscovered",
				creatureName = "Fallen Betrayer",
				potionName = "Serum of Resentment"
			},
			{
				flag = "isCrZombieswordmasterPotionDiscovered",
				creatureName = "Yaksha",
				potionName = "Elixir of Everlasting"
			},
			{
				flag = "isCrDemonhoundPotionDiscovered",
				creatureName = "Hollen Hound",
				potionName = "Headless Horseman\'s Anecdote"
			},			
			{
				flag = "isCrNecrosavantLordPotionDiscovered",
				creatureName = "Necrosavant Lord",
				potionName = "Potion of the Dustmourn"
			},
			{
				flag = "isCrAncientPraetorianiPotionDiscovered",
				creatureName = "Ancient Praetoriani",
				potionName = "Panacea for Gore"
			}
		])
		{
			if (::World.Statistics.getFlags().get(buff.flag))
			{
				result.push({
					id = 15,
					type = "text",
					icon = "ui/icons/special.png",
					text = "" + buff.creatureName + ": " + buff.potionName
				});
			}
			else
			{
				result.push({
					id = 15,
					type = "text",
					icon = "ui/icons/special.png",
					text = "" + buff.creatureName + ": " + "???"
				});
			}
		}

		return ret;
	}
});
