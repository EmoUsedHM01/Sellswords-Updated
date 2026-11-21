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

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.orc_warrior_potion_effect.Tooltip2
		});
		
		ret.push({
			id = 12,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = ::Mod_Sellswords.Strings.orc_warrior_potion_effect.Tooltip3
		});

		return ret;
	}

	
	q.onUpdate = @(__original) function(_properties)
	{
		__original(_properties);
		_properties.Hitpoints += 10;
	}

});