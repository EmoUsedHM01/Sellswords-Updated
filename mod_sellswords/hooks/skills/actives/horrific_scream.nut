::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/horrific_scream", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = ::Mod_Sellswords.Strings.horrific_scream.Description;
		this.m.Icon = "skills/ssu_active_41.png";
		this.m.IconDisabled = "skills/ssu_active_41_sw.png";
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
	}
	
	q.getTooltip = @(__original) function()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.horrific_scream.Tooltip, this.getMaxRange())
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