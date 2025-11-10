//"Improved Limbic System";
//"This character\'s limbic system has been altered with an additional substance that allows them to sustain particularly strenuous anaerobic activity for longer. Their skin seems vaguely greener than you remember, too, but you\'re sure that\'s a coincidence.";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/orc_warlord_potion_effect", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Name = "Improved Limbic System";
	}

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
				icon = "ui/icons/fatigue.png",
				text = "Using orc weapons no longer imposes additional fatigue costs" + "\n[color=%positive%]+10[/color] Fatigue."
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
		_properties.Stamina += 10;
	}

});