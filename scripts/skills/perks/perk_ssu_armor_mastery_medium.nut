this.perk_ssu_armor_mastery_medium <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_armor_mastery_medium";
		this.m.Name = this.Const.Strings.PerkName.SsuArmorMasteryMedium;
		this.m.Description = this.Const.Strings.PerkDescription.SsuArmorMasteryMedium;
		this.m.Icon = "ui/perks/ssu_armor_mastery_medium.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		local bonus = this.getBonus();

		if (bonus > 0)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_ssu_armor_mastery_medium.Tooltip1, bonus)
			});
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_ssu_armor_mastery_medium.Tooltip2, bonus)
			});
		}
		else if (this.getContainer().getActor().getBodyItem() == null)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.perk_ssu_armor_mastery_medium.Tooltip3
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.perk_ssu_armor_mastery_medium.Tooltip4
			});
		}

		return tooltip;
	}

	function getBonus()
	{
		local actor = this.getContainer().getActor();
		local bodyitem = actor.getBodyItem();
		local bonus = 0;

		if (bodyitem == null)
		{
			return 0;
		}

		local armorFatPen = actor.getItems().getStaminaModifier([
			::Const.ItemSlot.Body,
			::Const.ItemSlot.Head
		]) * -1;
		if (armorFatPen >= 20 && armorFatPen <= 40)
		{
			local currIni = actor.getInitiative();
			bonus = this.Math.floor(currIni /armorFatPen * 1.667);
		}
		return this.Math.min(bonus, 5);
	}

	function onAfterUpdate( _properties )
	{
		local bonus = this.getBonus();
		_properties.FatigueRecoveryRate += bonus;
		_properties.RangedDefense += bonus;
	}

});