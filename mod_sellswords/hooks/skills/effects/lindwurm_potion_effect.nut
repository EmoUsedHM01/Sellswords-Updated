//"Acidic blood";
//"This character\'s blood is highly pressurized and burns upon prolonged exposure to air. Attackers who break skin will find themselves unpleasantly surprised by the resultant spray.";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/lindwurm_potion_effect", function ( q ) {

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
			}
		];
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.lindwurm_potion_effect.Tooltip1
		});

		if (this.getContainer().getActor().getFlags().has("wurm_s"))
		{
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.lindwurm_potion_effect.Tooltip2
			});
		}
		else
		{
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.lindwurm_potion_effect.Tooltip3
			});
		}

		ret.push({
			id = 13,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = ::Mod_Sellswords.Strings.lindwurm_potion_effect.Tooltip4
		});

		return ret;
	}

	q.onUpdate <- function(_properties)
	{
		if (this.getContainer().getActor().getFlags().has("wurm_s"))
		{
			_properties.Hitpoints += 30;
			_properties.DamageTotalMult *= 1.30;
		}
		else
		{
			_properties.Hitpoints += 15;
			_properties.DamageTotalMult *= 1.15;
		}
	}

});