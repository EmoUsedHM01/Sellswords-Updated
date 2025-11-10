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
				text = "The threshold to sustain injuries on getting hit is increased by [color=%positive%]33%[/color]." + "\n[color=%positive%]+10[/color] Hitpoints."
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

	
	q.onUpdate = @(__original) function(_properties)
	{
		__original(_properties);
		_properties.Hitpoints += 10;
	}

});