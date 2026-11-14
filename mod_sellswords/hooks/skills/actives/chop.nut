::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/chop", function ( q ) {
	q.m.infantry <- false;

	q.getTooltip = @( __original ) function()
	{
		local ret = __original();

		foreach (i, tooltip in ret)
		{
			if (tooltip.id != 6) continue;

			local cd = 50;

			if (this.getContainer().hasSkill("perk.ssu_hack_spm"))
			{
				cd += 50;
			}

			if (this.m.infantry)
			{
				tooltip.text = ::Mod_Sellswords.Strings.chop.Tooltip1;
			}
			else
			{
				tooltip.text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.chop.Tooltip2, cd);
			}

			break;
		}
		
		return ret;
	}

	q.isHidden = @( __original ) function()
	{
		local shield = 1;
		if (this.getContainer().hasSkill("actives.shieldwall") || this.getContainer().hasSkill("actives.legend_fortify_skill"))
		{
			shield = 0;
		}
		return this.m.IsOrcWeapon == true && shield == 0;
	}

	q.onAnySkillUsed = @( __original ) function( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties);

		if (_skill == this)
		{
			if (this.getContainer().hasSkill("perk.ssu_hack_spm"))
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
