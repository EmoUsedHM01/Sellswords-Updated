::mods_hookExactClass("skills/actives/legend_field_treats", function(o) {
	o.m.Treated <- [];

	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.FatigueCost = 15;
		this.m.MinRange = 0;
	}

	o.getTooltip = function()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/asset_food.png",
				text = "You have [color=" + this.Const.UI.Color.PositiveValue + "]" + this.World.Assets.getFood() + "[/color] food."
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Spend [color=" + this.Const.UI.Color.NegativeValue + "]-20[/color] food to raise moral state of adjacent ally from wavering to steady."
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "reduces current fatigue by [color=" + this.Const.UI.Color.PositiveValue + "]-15%[/color]."
			}
		]);	
		return ret;
	}

	o.onVerifyTarget = function( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local food = this.World.Assets.getFood();

		if (food < 20)
		{
			return false;
		}

		local target = _targetTile.getEntity();

		if (target == null)
		{
			return false;
		}

		if (!this.m.Container.getActor().isAlliedWith(target))
		{
			return false;
		}
		
		foreach (ally in this.m.Treated)
		{
			if (ally  == target.getID())
			{
				return false;
			}
		}		

		//if (target.getMoraleState() >= this.Const.MoraleState.Steady)
		//{
		//	return false;
		//}

		return true;
	}

	local ws_onUse = o.onUse;
	o.onUse = function( _user, _targetTile )
	{
		local a = _targetTile.getEntity();
		this.m.Treated.push(a.getID());	
		a.setFatigue(this.Math.max(0, a.getFatigue() * 0.85));		
		return ws_onUse(_user, _targetTile);
	}
	
	o.onCombatFinished <- function()
	{		
		this.m.Treated.clear();
	}

});