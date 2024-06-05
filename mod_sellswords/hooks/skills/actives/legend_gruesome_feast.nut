::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_gruesome_feast", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.Description = "Feast on a corpse to regain vigor and cure injuries. Will daze and disgust any ally within four tiles.";
	}

	q.onUse = @( __original ) function( _user, _targetTile )
	{
		_user.setFatigue(this.Math.max(0, _user.getFatigue() - _user.getBaseProperties().Stamina * _user.getBaseProperties().StaminaMult * 0.10));
		return __original(_user, _targetTile);
	}

});