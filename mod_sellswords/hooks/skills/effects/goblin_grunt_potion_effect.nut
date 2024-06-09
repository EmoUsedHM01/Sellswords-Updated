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
				text = "The Action Point costs of the Rotation and Footwork skills are reduced to by [color=" + this.Const.UI.Color.PositiveValue + "]1[/color]."
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The Fatigue costs of the Rotation and Footwork skills are reduced by [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color]." + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Initiative."
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
		_properties.Initiative += 10;
	}

});
