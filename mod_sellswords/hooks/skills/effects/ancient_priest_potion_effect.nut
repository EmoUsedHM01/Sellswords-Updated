//"Synapse Blockage";
//"This character\'s body has mutated in such a way that their fight-or-flight response is altered. In high stress situations, their limbic system is simply refused resources for flight, making them effectively unbreakable in the battle line.";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/ancient_priest_potion_effect", function ( q ) {

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
				text = "Morale cannot be reduced below Steady\n" + "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Resolve."
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
		_properties.Bravery += 10;
	}

});