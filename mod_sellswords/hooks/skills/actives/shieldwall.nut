::mods_hookExactClass("skills/actives/shieldwall", function ( o )
{
	o.getTooltip = function ()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local mult = 1.0;
		local proficiencyBonus = 0;
		local dr = 100;

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)
		{
			mult = mult * 1.25;
		}

		if (this.getContainer().hasSkill("perk.crTotalcover"))
		{
			dr = dr - 20;
		}

		if (this.getContainer().getActor().getCurrentProperties().IsProficientWithShieldSkills)
		{
			proficiencyBonus = 10;
		}

		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 3,
			type = "text",
			text = this.getCostString()
		});
		tooltip.push({
			id = 4,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "Grants [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.floor(item.getMeleeDefense() * mult + proficiencyBonus) + "[/color] Melee Defense for one turn"
		});
		tooltip.push({
			id = 5,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = "Grants [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.floor(item.getRangedDefense() * mult + proficiencyBonus) + "[/color] Ranged Defense for one turn"
		});

		if (dr < 100)
		{
			tooltip.push({
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Only receive [color=" + this.Const.UI.Color.PositiveValue + "]" + dr + "%[/color] of any damage"
			});
		}

		return tooltip;
	};
});