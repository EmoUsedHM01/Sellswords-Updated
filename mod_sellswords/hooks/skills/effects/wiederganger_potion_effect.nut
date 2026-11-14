//"Subdermal Reactivity";
//"It\'s just a flesh wound! This character\'s subdermal flesh has mutated and automatically reacts to sudden trauma, lessening the chance to suffer injuries in battle.";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/wiederganger_potion_effect", function ( q ) {

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
				text = ::Mod_Sellswords.Strings.wiederganger_potion_effect.Tooltip1
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.wiederganger_potion_effect.Tooltip2
			}
		];
		return ret;
	}

	
	q.onUpdate = @(__original) function(_properties)
	{
		__original(_properties);
		_properties.Hitpoints += 10;
	}

});