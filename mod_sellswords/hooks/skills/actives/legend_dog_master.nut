::mods_hookExactClass("skills/actives/legend_dog_master", function(o) {
	
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.Description = "Use food to restore a friendly dog's morale";
		this.m.FatigueCost = 15;
		this.m.MaxRange = 7;
	}

	local ws_getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = ws_getTooltip();

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/asset_medicine.png",
			text = "You have [color=" + ::Const.UI.Color.PositiveValue + "]" + ::World.Assets.getMedicine() + "[/color] medicine."
		})

		return ret;
	}

	local ws_onVerifyTarget = o.onVerifyTarget;
	o.onVerifyTarget = function( _originTile, _targetTile )
	{
		if (!ws_onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		return this.getContainer().getActor().isAlliedWith(_targetTile.getEntity());
	}

	local ws_onUse = o.onUse;
	o.onUse = function( _user, _targetTile )
	{
		local ret = ws_onUse(_user, _targetTile);

		if (ret)
		{
			local target = _targetTile.getEntity();
			target.setMoraleState(this.Const.MoraleState.Confident);
			target.setHitpoints(this.Math.min(target.getHitpointsMax(), target.getHitpoints() + 40));	
		}
			
		return ret;
	}

})