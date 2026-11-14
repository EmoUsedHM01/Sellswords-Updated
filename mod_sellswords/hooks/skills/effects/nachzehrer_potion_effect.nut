//"Hyperactive Tissue Growth";
//"This character\'s body has mutated to regrow skin and muscle tissue much more quickly than normal. Deep injuries heal much faster than normal as a result. They also seem to have developed a strong taste for red meat, but that\'s probably unrelated.";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/nachzehrer_potion_effect", function ( q ) {

	q.getDescription = @(__original) function()
	{
		return ::Mod_Sellswords.Strings.nachzehrer_potion_effect.Text;
	}

	q.getTooltip = @(__original) function()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		
		if (this.getContainer().getActor().getFlags().has("ghoul_s"))
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = ::Mod_Sellswords.Strings.nachzehrer_potion_effect.Tooltip1
			});
		}
		else
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = ::Mod_Sellswords.Strings.nachzehrer_potion_effect.Tooltip2
			});
		}
		
		ret.push({
			id = 12,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = ::Mod_Sellswords.Strings.nachzehrer_potion_effect.Tooltip3
		});
		return ret;
	}

	q.onUpdate = @() function(_properties)
	{
		if (this.getContainer().getActor().getFlags().has("ghoul_s"))
			_properties.Initiative += 20;
		else
			_properties.Initiative += 10;
	}

});