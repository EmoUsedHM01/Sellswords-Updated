::mods_hookExactClass("items/misc/anatomist/research_notes_beasts_item", function (o) {
	local ws_getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = ws_getTooltip();

		foreach (buff in [
			{
				flag = "isCrBearDiscovered",
				creatureName = "Bear",
				potionName = "Potion of Thunder's Roar"
			},				
			{
				flag = "isCrDemonAlpPotionDiscovered",
				creatureName = "Demon Alp",
				potionName = "Umbral Horror\'s Manifest"
			},
			{
				flag = "isCrGreenSchratPotionDiscovered",
				creatureName = "Greenwood Schrat",
				potionName = "Draught of Sacred Grove"
			},
			{
				flag = "isCrLeaderHexePotionDiscovered",
				creatureName = "Hexe Leader",
				potionName = "Potion of Benevolence"
			},
			{
				flag = "isCrRedbackWebknechtPotionDiscovered",
				creatureName = "Redback Spider",
				potionName = "Scarlettincture Potion"
			},
			{
				flag = "isCrRockUnholdPotionDiscovered",
				creatureName = "Rock Unhold",
				potionName = "Titan's Grip Potion"
			},
			{
				flag = "isCrSkinNachzehrerPotionDiscovered",
				creatureName = "Skin Ghoul",
				potionName = "Potion of Malice Unguis"
			},
			{
				flag = "isCrStollwurmPotionDiscovered",
				creatureName = "Stoll Wurm",
				potionName = "Elixir of Dragonhide"
			},
			{
				flag = "isCrWhiteDirewolfPotionDiscovered",
				creatureName = "White Direwolf",
				potionName = "Potion of Blade Flurry"
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