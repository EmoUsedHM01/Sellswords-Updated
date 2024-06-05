::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_dog_master", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.Description = "Use food to restore a friendly dog's morale";
		this.m.FatigueCost = 15;
		this.m.MaxRange = 7;
	}

	q.getTooltip = @( __original ) function()
	{
		local ret = __original();

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/asset_medicine.png",
			text = "You have [color=" + ::Const.UI.Color.PositiveValue + "]" + ::World.Assets.getMedicine() + "[/color] medicine."
		})

		return ret;
	}

	q.onVerifyTarget = @( __original ) function( _originTile, _targetTile )
	{
		if (!__original(_originTile, _targetTile))
		{
			return false;
		}

		return this.getContainer().getActor().isAlliedWith(_targetTile.getEntity());
	}

	q.onUse = @( __original ) function( _user, _targetTile )
	{
		local ret = __original(_user, _targetTile);

		if (ret)
		{
			local target = _targetTile.getEntity();
			target.setMoraleState(this.Const.MoraleState.Confident);
			target.setHitpoints(this.Math.min(target.getHitpointsMax(), target.getHitpoints() + 40));	
		}
			
		return ret;
	}

});
