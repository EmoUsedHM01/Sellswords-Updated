::mods_hookExactClass("skills/effects/legend_fortify_effect", function ( o )
{
	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local mult = 1.0;
		local dr = 100;

		if (this.getContainer().hasSkill("perk.crTotalcover"))
		{
			dr = dr - 25;
		}

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)
		{
			mult = mult * 1.25;
		}

		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.floor(item.getMeleeDefense() * mult + 5) + "[/color] Melee Defense"
		});
		tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.floor(item.getRangedDefense() * mult + 5) + "[/color] Ranged Defense"
		});
		tooltip.push({
			id = 12,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "Grants an additional [color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Defense against all attacks."
		});

		if (dr < 100)
		{
			tooltip.push({
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Only receive [color=" + this.Const.UI.Color.PositiveValue + "]" + dr + "%[/color] of any damage"
			});
		}

		return tooltip;
	};
	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _properties )
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local dr = 100;

		if (this.getContainer().hasSkill("perk.crTotalcover"))
		{
			dr = dr - 25;
		}

		if (item.isItemType(this.Const.Items.ItemType.Shield) && item.getCondition() > 0)
		{
			local mult = 1.0;

			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)
			{
				mult = mult * 1.25;
			}

			_properties.MeleeDefense += this.Math.floor(item.getMeleeDefense() * mult + 5);
			_properties.RangedDefense += this.Math.floor(item.getRangedDefense() * mult + 5);
			_properties.DamageReceivedTotalMult *= dr * 0.01;
		}
	};
});	