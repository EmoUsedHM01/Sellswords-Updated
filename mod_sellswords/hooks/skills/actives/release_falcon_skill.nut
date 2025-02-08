::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/release_falcon_skill", function ( q ) {
	q.m.Turn <- 2;


	q.create = @(__original) function()
	{
		__original();

		this.m.Description = "Release your falcon to gain vision of the surrounding 12 tiles for the duration of the current round. Can be used every other turn.";
		this.m.ActionPointCost = 6;
	}

	q.getTooltip = @( __original ) function()
	{
		local ret = __original();

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/asset_medicine.png",
			text = "You have [color=" + ::Const.UI.Color.PositiveValue + "]" + ::World.Assets.getMedicine() + "[/color] medicine."
		});

		return ret;
	}

	q.isUsable = @( __original ) function()
	{
		return this.skill.isUsable() && this.m.Turn >= 2;
	}	
	
	q.isHidden <- function()
	{
		return this.m.Turn < 2;
	}

	q.onUpdate = @( __original ) function( _properties )
	{
	}

	q.onUse = @( __original ) function( _user, _targetTile )
	{
		this.m.Turn -= 2;
		return __original( _user, _targetTile );
	}

	q.onTurnStart <- function()
	{
		this.m.Turn += this.m.Turn < 2 ? 1 : 0;	
	}

	q.onCombatStarted <- function()
	{
		this.m.Turn = 1;			
	}
	
	q.onCombatFinished <- function()
	{
		this.m.Turn = 2;			
	}	

});
