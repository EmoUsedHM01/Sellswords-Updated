this.cr_delay_buff_effect <- this.inherit("scripts/skills/skill", {
	m = {
		MeleeSkillminus = 0,
		RangedSkillminus = 0,
		MeleeDefenseminus = 0,
		RangedDefenseminus = 0,
		TurnsLeft = 1,
	},
	function create()
	{
		this.m.ID = "effects.cr_delay_buff";
		this.m.Name = "Delay";
		this.m.Description = "This character has afforded the ability to mass fires more effectively.";
		this.m.Icon = "ui/perks/ptr_dynamic_duo.png";
		this.m.IconMini = "ptr_dynamic_duo_mini";
		this.m.SoundOnUse = [];
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
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.MeleeSkillminus + "[/color] Melee Skill"
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RangedSkillminus + "[/color] Ranged Skill"
		});		

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.MeleeDefenseminus + "[/color] Melee Defense"
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RangedDefenseminus + "[/color] Ranged Defense"
		});

		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkill += this.m.MeleeSkillminus;
		_properties.RangedDefense += this.m.RangedDefenseminus;
		_properties.MeleeDefense += this.m.MeleeDefenseminus;
		_properties.RangedSkill += this.m.RangedSkillminus;
	}
	
	function onAdded()
	{
		this.m.TurnsLeft = 1;
	}	
	
	function onTurnStart()
	{
		if (--this.m.TurnsLeft < 0)
		{
			this.removeSelf();
		}
	}
});
