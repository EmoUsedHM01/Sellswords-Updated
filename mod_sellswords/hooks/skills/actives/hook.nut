::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/hook", function ( q ) {

	q.onAfterUpdate = @( __original ) function ( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInPolearms ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.ActionPointCost = _properties.IsSpecializedInPolearms ? 5 : 6;

		local actor = this.getContainer().getActor().get();
		if (actor.getSkills().getSkillByID("perk.crGrandslam"))
			this.m.ActionPointCost += 1;

		this.m.FatigueCostMult *= this.getContainer().hasSkill("perk.crretrofithooks") ? 0.8 : 1.0;
	}

	q.getTooltip = @( __original ) function ()
	{
		local ret = this.getDefaultUtilityTooltip();
		local bonus = this.getContainer().hasSkill("perk.crretrofithooks") ? 20 : 10;
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]2[/color] tiles"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] chance to stagger on a hit"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + bonus + "%[/color] chance to hit"
		});
		return ret;
	}

	q.onAnySkillUsed = @( __original) function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += 10;

			if (this.getContainer().hasSkill("perk.crretrofithooks"))
				_properties.MeleeSkill += 10;
		}
	}

});