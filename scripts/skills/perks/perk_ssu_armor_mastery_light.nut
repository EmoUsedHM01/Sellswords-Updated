this.perk_ssu_armor_mastery_light <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_armor_mastery_light";
		this.m.Name = this.Const.Strings.PerkName.SsuArmorMasteryLight;
		this.m.Description = this.Const.Strings.PerkDescription.SsuArmorMasteryLight;
		this.m.Icon = "ui/perks/ssu_armor_mastery_light.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		local fm = this.Math.floor(this.getChance() * 100);
		return fm >= 100;
	}

	function getTooltip()
	{
		local fm = this.Math.round(this.getChance() * 100);
		local tooltip = this.skill.getTooltip();

		if (fm < 100)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_ssu_armor_mastery_light.Tooltip1, fm)
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.perk_ssu_armor_mastery_light.Tooltip2
			});
		}

		return tooltip;
	}

	function getChance()
	{
		local armorFat = this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);
		armorFat = this.Math.min(0, armorFat + 15);
		local ret = this.Math.minf(1.0, 0.74 + this.Math.pow(this.Math.abs(armorFat), 1.23) * 0.003);
		return ret;
	}

	function onUpdate(_properties)
	{
		local chance = this.getChance();
		_properties.FatigueEffectMult *= chance;
	}

});