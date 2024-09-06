::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_possession_skill", function ( q ) {

	q.getTooltip = @(__original) function()
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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getMaxRange() + "[/color] tiles."
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Empowers an undead until the end of their next turn."
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Grants;\n[color=" + this.Const.UI.Color.PositiveValue + "]12[/color] AP\n[color=" + this.Const.UI.Color.PositiveValue + "]+50[/color] Initiative\n[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color] Melee Skill\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee Defense\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Ranged Defense\nOnly takes [color=" + this.Const.UI.Color.NegativeValue + "]75%[/color] damage from attacks."
			}
		];
	}

});