::Mod_Sellswords.HooksMod.hook("scripts/items/misc/anatomist/research_notes_legendary_item", function ( q )  {

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		local new =
		{
			flag = "isCrConquerorPotionDiscovered",
			creatureName = " The Conqueror",
			potionName = "Fleeting Reminiscence of Caesar"
		};

		if (::World.Statistics.getFlags().get(new.flag))
		{
			result.push({
				id = 15,
				type = "text",
				icon = "ui/icons/special.png",
				text = "" + new.creatureName + ": " + new.potionName
			});
		}
		else
		{
			result.push({
				id = 15,
				type = "text",
				icon = "ui/icons/special.png",
				text = "" + new.creatureName + ": " + "???"
			});
		}

		return ret;
	}
});
