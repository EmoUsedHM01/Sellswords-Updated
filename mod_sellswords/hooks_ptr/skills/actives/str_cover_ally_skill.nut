::mods_hookExactClass("skills/actives/str_cover_ally_skill", function ( o )
{
	o.getTooltip = function ()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Allows the target to move 1 tile ignoring zone of control on their turn"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "In the next round the target\'s turn order is calculated with [color=" + this.Const.UI.Color.NegativeValue + "]+2000[/color] Initiative"
			},
		]);

		local actor = this.getContainer().getActor();
		if (!actor.isArmedWithShield())
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Requires a shield[/color]"
			});
		}

		if (!actor.getCurrentProperties().IsRooted || actor.getCurrentProperties().IsStunned)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Cannot be used while Rooted or Stunned"
			});
		}

		if (this.getContainer().hasSkill("effects.str_covering_ally"))
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Cannot be used when already providing cover to an ally[/color]"
			});
		}

		return ret;
	}
});	