//"Mutated Cornea";
//"This character\'s eyes have been permanently mutated and are now capable of detecting the subtlest movements of wind and air. While minor on its own, this allows them to better predict the trajectory of projectile attacks and better land hits on vulnerable parts of a target.";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/goblin_overseer_potion_effect", function ( q ) {

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
				text = ::Mod_Sellswords.Strings.goblin_overseer_potion_effect.Tooltip1
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.goblin_overseer_potion_effect.Tooltip2
			}
		];
		return ret;
	}

	q.onUpdate = @(__original) function(_properties)
	{
		_properties.IsSharpshooter = true;
		_properties.RangedSkill += 10;
		_properties.RangedDefense += 10;
	}

});