//"Elasticized Sinew";
//"This character\'s muscles have mutated and respond differently to movement impulses. It is much less fatiguing to interrupt or stop mid-motion as a consequence, making it much easier to recover from errant or blocked attacks.";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/direwolf_potion_effect", function ( q ) {

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
				text = ::Mod_Sellswords.Strings.direwolf_potion_effect.Tooltip1
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.direwolf_potion_effect.Tooltip2
			}
		];
		return ret;
	}

	q.onUpdate <- function(_properties)
	{
		_properties.Stamina += 10;
	}

});