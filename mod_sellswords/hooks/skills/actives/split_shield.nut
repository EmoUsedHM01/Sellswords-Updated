::mods_hookExactClass("skills/actives/split_shield", function ( o )
{
	local onUse = o.onUse;
	o.onUse = function ( _user, _targetTile )
	{
		local shield = _targetTile.getEntity().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local ret = onUse(_user, _targetTile);

		if (ret && shield != null && shield.getCondition() == 0 && this.getContainer().hasSkill("perk.legend_smashing_shields"))
		{
			local sms = this.getContainer().getSkillByID("actives.split_shield");
			local fatrefund = sms.m.FatigueCost;
			_user.setFatigue(this.Math.max(0, _user.getFatigue() - 0.5 * fatrefund));
		}

		return ret;
	};
});