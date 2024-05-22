::mods_hookExactClass("skills/effects/goblin_grunt_potion_effect", function(o) {
	o.getTooltip = function()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "The Action Point costs of the Rotation and Footwork skills are reduced to [color=" + this.Const.UI.Color.PositiveValue + "]2[/color], while the Kata Step skill is reduced by [color=" + this.Const.UI.Color.PositiveValue + "]1[/color]"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "The Fatigue costs of the Rotation, Footwork and Kata Step skills are reduced by [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color]"
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations will cause a longer period of sickness"
			}
		];
	}
})