::mods_hookExactClass("skills/actives/legend_gruesome_feast", function(o) {
	
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.Description = "Feast on a corpse to regain vigor and cure injuries. Will daze and disgust any ally within four tiles.";
	}

	local ws_onUse = o.onUse;
	o.onUse = function(_user, _targetTile)
	{
		_user.setFatigue(this.Math.max(0, _user.getFatigue() - _user.getBaseProperties().Stamina * _user.getBaseProperties().StaminaMult * 0.10));
		return ws_onUse(_user, _targetTile);
	}

})