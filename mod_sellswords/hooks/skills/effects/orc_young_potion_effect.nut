//"Shock Absorbant Wrists";
//"This character\'s wrists have mutated in such a way that the they dampen the initial shock of opposing forces. In more practical terms, they reduce the protective qualities of an enemy\'s armor when struck. They can also make some pretty outlandish shadow puppets.";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/orc_young_potion_effect", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Name = ::Mod_Sellswords.Strings.orc_young_potion_effect.Name;
	}

	q.getDescription = @(__original) function()
	{
		return ::Mod_Sellswords.Strings.orc_young_potion_effect.Text;
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
			}
		];

		if (this.getContainer().getActor().getFlags().has("orc_w"))
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::Mod_Sellswords.Strings.orc_young_potion_effect.Tooltip1
			});
		}
		else
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::Mod_Sellswords.Strings.orc_young_potion_effect.Tooltip2
			});
		}
		
		ret.push({
			id = 12,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = ::Mod_Sellswords.Strings.orc_young_potion_effect.Tooltip3
		});

		return ret;
	}

	
	q.onUpdate = @(__original) function(_properties)
	{
		if (this.getContainer().getActor().getFlags().has("orc_w"))
			_properties.DamageTotalMult *= 1.2;
		else
			_properties.DamageTotalMult *= 1.1;
	}

});