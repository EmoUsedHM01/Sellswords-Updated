::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_ranged_flail_skill", function ( q ) {

	q.getTooltip = @( __original ) function()
	{
		local ret = __original();

		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]2[/color] tiles"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Ignores the bonus to Melee Defense granted by shields"
			}
		]);

		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
			});
		}		

		return ret;
	}

	q.onAnySkillUsed <- function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				this.m.HitChanceBonus = -15;
			}
			else
			{
				this.m.HitChanceBonus = 0;
			}
		}
	}
});
