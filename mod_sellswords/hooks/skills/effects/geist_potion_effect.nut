//"Kinetic Coating";
//"This character is able to secrete a substance that vibrates rapidly when stimulated. When applied to weapons, this creates a strong kinetic force that aids in armor penetration.";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/geist_potion_effect", function ( q ) {

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
				text = "An additional [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] of damage ignores armor when using melee weapons."
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
		_properties.DamageDirectMeleeAdd += 0.10;
	}

});