this.cr_delay_debuff_effect <- this.inherit("scripts/skills/skill", {
	m = {
		MeleeSkillminus = 0,
		RangedSkillminus = 0,
		MeleeDefenseminus = 0,
		RangedDefenseminus = 0		
	},
	function create()
	{
		this.m.ID = "effects.cr_delay_debuff";
		this.m.Name = "Delay";
		this.m.Description = "Time may be needed so this character can regain the initiative by going on the offense. This time is often necessary to set the conditions logistically for the offensive."
		this.m.Icon = "ui/perks/ptr_dynamic_duo.png";
		this.m.IconMini = "ptr_dynamic_duo_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.MeleeSkillminus + "[/color] Melee Skill"
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.RangedSkillminus + "[/color] Ranged Skill"
		});
		
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.MeleeDefenseminus + "[/color] Melee Defense"
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.RangedDefenseminus + "[/color] Ranged Defense"
		});		

		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkill -= this.m.MeleeSkillminus;
		_properties.RangedDefense -= this.m.RangedDefenseminus;
		_properties.MeleeDefense -= this.m.MeleeDefenseminus;
		_properties.RangedSkill -= this.m.RangedSkillminus;
	}
	
	function onTurnStart()
	{
		this.removeSelf();
	}
});
