::mods_hookExactClass("skills/actives/ptr_arrow_to_the_knee_skill", function ( o )
{
	o.getTooltip = function ()
	{
		local tooltip = this.skill.getDefaultUtilityTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]50%[/color] reduced Ranged Damage"
			},
			//{
			//	id = 10,
			//	type = "text",
			//	icon = "ui/icons/ranged_skill.png",
			//	text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] Ranged Skill"
			//},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.NegativeValue + "]0%[/color] chance to hit the head"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Target will have [color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Melee and Ranged defense for 1 turn and [color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] in the turn after that"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Target will require [color=" + this.Const.UI.Color.NegativeValue + "]2[/color] additional Action Points per tile moved for 1 turn and [color=" + this.Const.UI.Color.NegativeValue + "]1[/color] in the turn after that"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "Target will have [color=" + this.Const.UI.Color.NegativeValue + "]-30%[/color] Initiative for 1 turn and [color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] in the turn after that"
			}
		]);

		if (this.getContainer().getActor().isEngagedInMelee())
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Not usable when engaged in melee"
			});
		}

		return tooltip;
	};
});