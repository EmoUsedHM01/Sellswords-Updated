::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/shieldwall_effect", function ( q ) {

	q.getTooltip = @(__original) function()
	{
		local bonus = this.getBonus();
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local dr = 100;
		local mult = 1.0;
		local proficiencyBonus = 0;

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)
		{
			mult = mult * 1.25;
		}

		if (this.getContainer().getActor().getCurrentProperties().IsProficientWithShieldSkills)
		{
			proficiencyBonus = 10;
		}

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)
		{
			mult = mult * 1.25;
		}

		if (this.getContainer().hasSkill("perk.ssu_totalcover"))
		{
			dr = dr - 20;
		}

		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 2,
			type = "description",
			text = this.getDescription() + (bonus > 0 ? " For forming a sturdy shieldwall with allies nearby, the defense is increased further." : "")
		});
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.shieldwall_effect.Tooltip1, this.Math.floor(item.getMeleeDefense() * mult + bonus + proficiencyBonus))
		});
		tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.shieldwall_effect.Tooltip2, this.Math.floor(item.getRangedDefense() * mult + bonus + proficiencyBonus))
		});

		if (dr < 100)
		{
			tooltip.push({
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.shieldwall_effect.Tooltip3, dr)
			});
		}

		return tooltip;
	}
	
	q.onAfterUpdate <- function ( _properties )
	{
		local dr = 100;

		if (this.getContainer().hasSkill("perk.ssu_totalcover"))
		{
			dr = dr - 20;
		}

		_properties.DamageReceivedTotalMult *= dr * 0.01;
	}
});
