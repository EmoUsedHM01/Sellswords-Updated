//"Locking Joints";
//"This character\'s body has mutated such that they can lock their limbs into certain positions almost indefinitely, allowing them to brace against blows while barely breaking a sweat.";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/skeleton_warrior_potion_effect", function ( q ) {

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
				text = "Reduces the Fatigue cost of the \'Shieldwall\' skill by [color=%positive%]" + 100 * (1 - this.Const.Combat.WeaponSpecFatigueMult) + "%[/color]" + "\n[color=%positive%]+10[/color] Melee Defense." + "\n[color=%positive%]+10[/color] Fatigue."
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
		_properties.MeleeDefense += 10;
		_properties.Stamina += 10;
	}

});