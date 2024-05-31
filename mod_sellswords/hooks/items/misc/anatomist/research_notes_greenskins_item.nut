::Mod_Sellswords.HooksMod.hook("scripts/items/misc/anatomist/research_notes_greenskins_item", function ( q )  {

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		foreach (buff in [
			{
				flag = "isCrOrcBehemothPotionDiscovered",
				creatureName = "Orc Behemoth",
				potionName = "Blood of Unchained Fury"
			},			
			{
				flag = "isCrOrcElitePotionDiscovered",
				creatureName = "Orc Elite",
				potionName = "Savage Tipple"
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
