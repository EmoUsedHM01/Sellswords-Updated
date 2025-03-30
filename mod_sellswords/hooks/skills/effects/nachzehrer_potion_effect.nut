//"Hyperactive Tissue Growth";
//"This character\'s body has mutated to regrow skin and muscle tissue much more quickly than normal. Deep injuries heal much faster than normal as a result. They also seem to have developed a strong taste for red meat, but that\'s probably unrelated.";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/nachzehrer_potion_effect", function ( q ) {

	q.getDescription = @(__original) function()
	{
		return "This character\'s body has mutated to regrow skin and muscle tissue much more quickly than normal and they gain the speed of nachzehrer. Deep injuries heal much faster than normal as a result. They also seem to have developed a hunger for fresh meat, but that\'s probably unrelated.";
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
				text = "Reduces the time it takes to heal from any injury by one day, down to a mininum of one day." + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+20[/color] Initiative."
			});
		}
		else
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "Reduces the time it takes to heal from any injury by one day, down to a mininum of one day." + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Initiative."
			});
		}
		
		ret.push({
			id = 12,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
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