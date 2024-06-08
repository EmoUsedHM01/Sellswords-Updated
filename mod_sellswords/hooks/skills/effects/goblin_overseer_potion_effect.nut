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
				text = "An additional [color=" + this.Const.UI.Color.PositiveValue + "]5%[/color] of damage ignores armor when using bows or crossbows." + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Ranged Skill."  + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Ranged Defense."
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
		_properties.IsSharpshooter = true;
		_properties.RangedSkill += 10;
		_properties.RangedDefense += 10;
	}

});