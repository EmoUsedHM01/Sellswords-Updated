::mods_hookExactClass("skills/actives/split_shield", function ( o )
{
	local ws_onUse = o.onUse;
	o.onUse = function ( _user, _targetTile )
	{
		local shield = _targetTile.getEntity().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local ret = ws_onUse(_user, _targetTile);

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
	};

});