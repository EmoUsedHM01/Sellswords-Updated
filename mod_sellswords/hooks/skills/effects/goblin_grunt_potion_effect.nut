//"Reactive Leg Muscles";
//"This character\'s legs have been mutated, allowing them to make swift, complex movements more smoothly and with greater rapidity. When at rest, the muscles can still occasionally be seen twitching underneath the skin.";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/goblin_grunt_potion_effect", function ( q ) {

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
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.goblin_grunt_potion_effect.Tooltip1
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.goblin_grunt_potion_effect.Tooltip2
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.goblin_grunt_potion_effect.Tooltip3
			}
		];
		return ret;
	}
	
	q.onUpdate = @(__original) function(_properties)
	{
		__original(_properties);
		_properties.Initiative += 10;
	}

});
