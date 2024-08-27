this.perk_armor_mastery_cloth <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.armor_mastery_cloth";
		this.m.Name = this.Const.Strings.PerkName.ArmorMasteryCloth;
		this.m.Description = this.Const.Strings.PerkDescription.ArmorMasteryCloth;
		this.m.Icon = "ui/perks/crSpecialize_ca.png";
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
				text = "additional [color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Fatigue Recovery"
			});
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Ranged Defense"
			});
		}
		else if (this.getContainer().getActor().getBodyItem() == null)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character is not wearing any body armor and hence receives no bonus from this perk"
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character\'s armor is too light or too heavy or their Initiative is too low to receive any bonus from this perk"
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
