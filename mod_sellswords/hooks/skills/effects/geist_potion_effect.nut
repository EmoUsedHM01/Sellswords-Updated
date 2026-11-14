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
				text = ::Mod_Sellswords.Strings.geist_potion_effect.Tooltip1
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.geist_potion_effect.Tooltip2
			}
		];
		return ret;
	}
	
	q.onUpdate = @(__original) function(_properties)
	{
		_properties.DamageDirectMeleeAdd += 0.10;
	}

});