::mods_hookExactClass("skills/actives/chop", function(o) {
	o.m.orc <- false;
	o.m.infantry <- false;

	local ws_getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = ws_getTooltip();

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
				tooltip.text = "Always hit the body part.";
			}
			else
			{
				tooltip.text = "Inflicts additional [color=" + this.Const.UI.Color.PositiveValue + "]" + cd + "%[/color] damage on a hit to the head";
			}

			break;
		}
		
		return ret;
	}

	o.isHidden <- function()
	{
		//local off = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local shield = 1;
		if (this.getContainer().hasSkill("actives.shieldwall") || this.getContainer().hasSkill("actives.legend_fortify_skill"))
		{
			shield = 0;
		}
		return this.m.orc == true && shield == 0;
	}

	local ws_onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		ws_onAnySkillUsed(_skill, _targetEntity, _properties);

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
})