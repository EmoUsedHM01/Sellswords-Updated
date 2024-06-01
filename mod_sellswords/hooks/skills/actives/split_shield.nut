::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/split_shield", function( q ) {

	q.onAfterUpdate = @(__original) function( _properties )
	{
		this.m.FatigueCostMult = this.m.ApplyAxeMastery && _properties.IsSpecializedInAxes ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;

		if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getBlockedSlotType() != null)
		{
			this.m.ActionPointCost = _properties.IsSpecializedInPolearms ? 5 : 6;
		}
		else
		{
			this.m.ActionPointCost = 4;
		}
	}

	q.onUse = @(__original) function( _user, _targetTile )
	{
		local shield = _targetTile.getEntity().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local ret = __original(_user, _targetTile);

		if (ret && shield != null && shield.getCondition() == 0 && this.getContainer().hasSkill("perk.legend_smashing_shields"))
		{
			local sms = this.getContainer().getSkillByID("actives.split_shield");
			local fatrefund = sms.m.FatigueCost;
			_user.setFatigue(this.Math.max(0, _user.getFatigue() - 0.5 * fatrefund));
			if(!::Is_PTR_Exist)
			{
				_user.setActionPoints(this.Math.min(_user.getActionPointsMax(), _user.getActionPoints() + 4));
				this.spawnIcon("perk_legend_smashing_shields", _user.getTile());
			}
		}

		return ret;
	}

});