::mods_hookExactClass("skills/actives/release_falcon_skill", function(o) {
	o.m.Turn <- 2;

	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.Description = "Release your falcon to gain vision of the surrounding 12 tiles for the duration of the current round. Can be used every other turn.";
		this.m.ActionPointCost = 6;
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

	o.isUsable = function()
	{
		return this.skill.isUsable() && this.m.Turn >= 2;
	}	
	
	o.isHidden <- function()
	{
		return this.m.Turn < 2;
	}

	o.onUpdate = function( _properties )
	{
	}

	local ws_onUse = o.onUse;
	o.onUse = function( _user, _targetTile )
	{
		this.m.Turn -= 2;
		return ws_onUse(_user,_targetTile);
	}

	o.onTurnStart <- function()
	{
		this.m.Turn += this.m.Turn < 2 ? 1 : 0;	
	}

	o.onCombatStarted <- function()
	{
		this.m.Turn = 1;			
	}
	
	o.onCombatFinished <- function()
	{
		this.m.Turn = 2;			
	}	

});