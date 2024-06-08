//"Sensory Redundancy";
//"This character\'s body has mutated to develop a number of redundant synapses, allowing them to maintain a degree of control over sight, hearing, and muscle control even when struck with debilitating blows.";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/orc_warrior_potion_effect", function ( q ) {

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

		if (this.getContainer().getActor().getFlags().has("orc_w"))
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]33%[/color] chance to resist the Dazed, Staggered, Stunned, Distracted, and Withered status effects" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+20[/color] Hitpoints."
			});
		}
		else
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]33%[/color] chance to resist the Dazed, Staggered, Stunned, Distracted, and Withered status effects" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints."
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

	
	q.onUpdate = @(__original) function(_properties)
	{
		__original(_properties);
		if (this.getContainer().getActor().getFlags().has("orc_w"))
			_properties.Hitpoints += 20;
		else
			_properties.Hitpoints += 10;
	}

});