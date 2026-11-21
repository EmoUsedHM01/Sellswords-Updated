// shared by all Sequence potions. A potion only names its Sequence and whether it is the stronger Strain
this.ssu_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {
		Sequence = "",
		IsStrong = false
	},
	function create()
	{
		this.anatomist_potion_item.create();
	}

	function getTooltip()
	{
		local result = [
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
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		// the stronger Strain comes with everything of the weaker one
		local strings = ::Mod_Sellswords.Strings["ssu_" + this.m.Sequence + "_sequence_effect"];
		local texts = clone strings.Weak;

		if (this.m.IsStrong)
			texts.extend(strings.Strong);

		foreach (text in texts)
		{
			result.push({
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = text
			});
		}

		result.push({
			id = 15,
			type = "text",
			text = ::Mod_Sellswords.Strings.ssu_sequence_item.Use
		});
		result.push({
			id = 16,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = ::Mod_Sellswords.Strings.ssu_sequence_item.Sickness
		});
		result.push({
			id = 17,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = ::Mod_Sellswords.Strings.ssu_sequence_item.Warning
		});
		return result;
	}

	function onUse( _actor, _item = null )
	{
		::Mod_Sellswords.checkSequence(_actor, ::Mod_Sellswords.Sequences[this.m.Sequence].Flag);
		::Mod_Sellswords.addSequence(_actor, this.m.Sequence, this.m.IsStrong);
		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});
