::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/shieldwall", function ( q ) {

	q.getTooltip = @( __original ) function ()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local mult = 1.0;
		local proficiencyBonus = 0;
		local dr = 100;

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)
		{
			mult = mult * 1.25;
		}

		if (this.getContainer().hasSkill("perk.ssu_totalcover"))
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
			text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.shieldwall.Tooltip1, this.Math.floor(item.getMeleeDefense() * mult + proficiencyBonus))
		});
		tooltip.push({
			id = 5,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.shieldwall.Tooltip2, this.Math.floor(item.getRangedDefense() * mult + proficiencyBonus))
		});

		if (dr < 100)
		{
			tooltip.push({
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.shieldwall.Tooltip3, dr)
			});
		}

		return tooltip;
	};
});
