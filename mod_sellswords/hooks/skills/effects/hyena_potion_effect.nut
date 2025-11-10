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
				text = "Damage received from the Bleeding status effect is reduced by [color=%negative%]50%[/color]." + "\n[color=%positive%]+10[/color] Hitpoints."
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
			}
		];
		return ret;
	}

	q.onUpdate <- function(_properties)
	{
		_properties.Hitpoints += 10;
	}

});