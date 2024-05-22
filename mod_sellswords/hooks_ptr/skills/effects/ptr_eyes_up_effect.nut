::mods_hookExactClass("skills/effects/ptr_eyes_up_effect", function ( o )
{
	o.getTooltip = function ()
	{
		local tooltip = this.skill.getTooltip();
		local skillMalus = this.getSkillMalus();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + skillMalus + "[/color] Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + skillMalus + "[/color] Ranged Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.getDefenseMalus() + "[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.getDefenseMalus() + "[/color] Ranged Defense"
			}
		]);
		return tooltip;
	};
	o.onRefresh = function ()
	{
		if (this.m.Stacks < 5)
		{
			this.m.Stacks++;
			this.spawnIcon("ptr_eyes_up_effect", this.getContainer().getActor().getTile());		
		}
	}		
	o.onUpdate = function ( _properties )
	{
		local skillMalus = this.getSkillMalus();
		_properties.MeleeSkill -= skillMalus;
		_properties.RangedSkill -= skillMalus;
		_properties.MeleeDefense -= this.getDefenseMalus();
		_properties.RangedDefense -= this.getDefenseMalus();
	};
});