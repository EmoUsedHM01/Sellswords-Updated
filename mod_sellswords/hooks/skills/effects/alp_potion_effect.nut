//"Enhanced Eye Rods";
//"This character\'s eyes have mutated to respond faster and more drastically to low light environments. As a result, they have night vision nearly on par with their sight during the day.";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/alp_potion_effect", function ( q ) {

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
				icon = "ui/icons/morale.png",
				text = ::Mod_Sellswords.Strings.alp_potion_effect.Tooltip1
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.alp_potion_effect.Tooltip2
			}
		];
		return ret;
	}

	q.onUpdate = @(__original) function(_properties)
	{
		__original(_properties);
		_properties.Vision += 1;
	}

});