::mods_hookExactClass("items/misc/anatomist/research_notes_greenskins_item", function (o) {
	local ws_getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = ws_getTooltip();

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
})