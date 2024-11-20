::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_dog_handling_skill", function ( q ) {	

	q.onVerifyTarget = @(__original) function ( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local target = _targetTile.getEntity();
		local xp = target.getXPValue();
		local food = this.World.Assets.getFood();
		this.m.Food = food;
		if (target.getType() != this.Const.EntityType.Wardog && target.getType() != this.Const.EntityType.Warhound)
		{
			return false;
		}

		if (food < 25 )
		{
			return false;
		}

		return true;
	}
});
