::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_heightened_reflexes", function( q )
{
	q.onUpdate = @( __original ) function ( _properties )
	{
		__original( _properties );
		if (_properties.isCloseCombatArcher && this.getContainer().getActor().getCurrentProperties().Initiative > 150)
		{
			_properties.isFastAf = true;
		}
	}

	q.getTooltip = @( __original ) function ()
	{
		local actor = this.getContainer().getActor().getCurrentProperties();
		local tooltip = this.skill.getTooltip();

		if (actor.isCloseCombatArcher && actor.Initiative > 150)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Reduces Action Point cost by [color=" + this.Const.UI.Color.NegativeValue + "]1[/color] for [color=#400080]Shoot Bolt[/color], [color=#400080]Shoot Stake[/color], [color=#400080]Fire Handgonne[/color], [color=#400080]Quick Shot[/color] and [color=#400080]Sling Stone[/color] due to heightened reflexes"
			});
		}

		return tooltip;
	}

	q.onAfterUpdate <- function( _properties )
	{
		if (_properties.isCloseCombatArcher && this.getContainer().getActor().getCurrentProperties().Initiative > 150)
		{
			local skills = this.getContainer().getAllSkillsOfType(this.Const.SkillType.Active);
			foreach (skill in skills)
			{
				if (skill.isAttack() && (skill.getID() == "actives.shoot_bolt" || skill.getID() == "actives.quick_shot" || skill.getID() == "actives.fire_handgonne" || skill.getID() == "actives.sling_stone" || skill.getID() == "actives.shoot_stake"))
				{
					s.m.ActionPointCost -= 1;
				}		
			}
		}
	}
});
