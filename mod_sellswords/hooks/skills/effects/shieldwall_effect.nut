::mods_hookExactClass("skills/effects/shieldwall_effect", function ( o )
{
	o.getTooltip = function ()
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

		if (this.getContainer().hasSkill("perk.crTotalcover"))
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
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.floor(item.getMeleeDefense() * mult + bonus + proficiencyBonus) + "[/color] Melee Defense"
		});
		tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.floor(item.getRangedDefense() * mult + bonus + proficiencyBonus) + "[/color] Ranged Defense"
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
	
	o.onAfterUpdate <- function ( _properties )
	{
		local dr = 100;

		if (this.getContainer().hasSkill("perk.crTotalcover"))
		{
			dr = dr - 20;
		}

		_properties.DamageReceivedTotalMult *= dr * 0.01;
	};
});