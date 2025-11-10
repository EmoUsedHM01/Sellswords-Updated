//"Subdermal Stitching";
//"This character\'s skin and subdermal tissue has mutated and will rapidly stitch itself back together. The effect is most pronounced on small puncture wounds, where the flesh can seal the wound from all directions evenly.";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/honor_guard_potion_effect", function ( q ) {

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
				text = "This character takes between [color=%positive%]25%[/color] and [color=%positive%]50%[/color] less damage from piercing attacks, such as those from bows or spears." + "\n[color=%positive%]+10[/color] Hitpoints."
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