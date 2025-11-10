//"Reactive Muscle Tissue";
//"This character\'s body reacts to physical trauma, secreting a calciferous substance that causes their muscles to reflexively sieze and contract at points of impact to minimize muscle damage.";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/fallen_hero_potion_effect", function ( q ) {

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
				text = "This character accumulates no Fatigue from enemy attacks, whether they hit or miss\n" + "[color=%positive%]+10[/color] Hitpoints."
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