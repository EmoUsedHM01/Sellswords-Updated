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
				text = ::Mod_Sellswords.Strings.fallen_hero_potion_effect.Tooltip1
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.fallen_hero_potion_effect.Tooltip2
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