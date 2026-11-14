//"Subdermal Clotting"
//"When this character\'s skin is broken, a substance is secreted that drastically quickens the blood clotting process in the area. Bleeding wounds are much less harmful as a result, although some blood loss still occurs.";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/hyena_potion_effect", function ( q ) {

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
				icon = "ui/icons/health.png",
				text = ::Mod_Sellswords.Strings.hyena_potion_effect.Tooltip1
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.hyena_potion_effect.Tooltip2
			}
		];
		return ret;
	}

	q.onUpdate <- function(_properties)
	{
		_properties.Hitpoints += 10;
	}

});