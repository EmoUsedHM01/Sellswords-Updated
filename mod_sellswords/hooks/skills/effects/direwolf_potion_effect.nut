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
				text = "Attacks that miss have [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] of their Fatigue cost refunded" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Fatigue."
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
		_properties.Stamina += 10;
	}

});