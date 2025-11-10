::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/horrific_scream", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "Let out a piercing, unworldly sound that is sure to distress anyone unfortunate enough to hear it.";
		this.m.Icon = "skills/active_41.png";
		this.m.IconDisabled = "skills/active_41_sw.png";
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
	}
	
	q.getTooltip = @(__original) function()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=%positive%]" + this.getMaxRange() + "[/color] tiles"
		});
		return ret;
	}

	q.onUse = @(__original) function( _user, _targetTile )
	{
		local ret = __original(_user, _targetTile);

		if (_user.m.IsMiniboss)
		{
			_targetTile.getEntity().checkMorale(-1, -25, this.Const.MoraleCheckType.MentalAttack);
			_targetTile.getEntity().checkMorale(-1, -35, this.Const.MoraleCheckType.MentalAttack);
		}
		
		return ret;
	}

});