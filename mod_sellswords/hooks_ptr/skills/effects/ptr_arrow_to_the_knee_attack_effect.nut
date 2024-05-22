::mods_hookExactClass("skills/effects/ptr_arrow_to_the_knee_attack_effect", function ( o )
{
	o.getTooltip = function ()
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
				id = 10,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]50%[/color] reduced Ranged Damage"
			},
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
		];
	};
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && _skill.isRanged())
		{				
			_properties.HitChanceMult[this.Const.BodyPart.Head] = 0.0;
			_properties.HitChanceMult[this.Const.BodyPart.Body] = 1.0;
		}
	}
});	