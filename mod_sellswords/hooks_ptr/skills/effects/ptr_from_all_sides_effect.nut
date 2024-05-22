::mods_hookExactClass("skills/effects/ptr_from_all_sides_effect", function(o) {
	o.getTooltip = function()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.extend(
		[
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.Malus + "[/color] Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.Malus + "[/color] Melee Defense"
			}
		]);

		return tooltip;
	}

	o.onUpdate = function( _properties )
	{
		_properties.MeleeDefense -= this.m.Malus;
		_properties.MeleeSkill -= this.m.Malus;
	}

	o.onTurnStart = function()
	{
		this.m.Malus -= 5;
		if (this.m.Malus <= 0)
		{
			this.removeSelf();
		}
	}
	
	o.onTurnEnd <- function()
	{
		this.m.Malus -= 5;
		if (this.m.Malus <= 0)
		{
			this.removeSelf();
		}
	}	
})