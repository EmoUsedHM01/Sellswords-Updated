::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/chop", function ( q ) {
	q.m.orc <- false;
	q.m.infantry <- false;

	q.getTooltip = @( __original ) function()
	{
		local ret = __original();

		foreach (i, tooltip in ret)
		{
			if (tooltip.id != 6) continue;

			local cd = 50;

			if (this.getContainer().hasSkill("perk.crHackSPM"))
			{
				cd += 50;
			}

			if (this.m.infantry)
			{
				tooltip.text = "Always hits the body.";
			}
			else
			{
				tooltip.text = "Inflicts additional [color=" + this.Const.UI.Color.PositiveValue + "]" + cd + "%[/color] damage on a hit to the head";
			}

			break;
		}
		
		return ret;
	}

	q.isHidden <- function()
	{
		//local off = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local shield = 1;
		if (this.getContainer().hasSkill("actives.shieldwall") || this.getContainer().hasSkill("actives.legend_fortify_skill"))
		{
			shield = 0;
		}
		return this.m.orc == true && shield == 0;
	}

	q.onAnySkillUsed = @( __original ) function( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties);

		if (_skill == this)
		{
			if (this.getContainer().hasSkill("perk.crHackSPM"))
			{
				_properties.DamageAgainstMult[this.Const.BodyPart.Head] += 0.5;
			}
			
			if (this.m.infantry)
			{			
				_properties.HitChanceMult[this.Const.BodyPart.Head] = 0.0;
				_properties.HitChanceMult[this.Const.BodyPart.Body] = 1.0;
			}
		}
	}
});
