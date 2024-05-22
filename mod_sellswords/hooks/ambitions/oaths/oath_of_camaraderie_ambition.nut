::mods_hookExactClass("ambitions/oaths/oath_of_camaraderie_ambition", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.OathBoonText = "You can take up to [color=" + this.Const.UI.Color.PositiveValue + "]18[/color] men into battle.";
	}
	local ws_onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function()
	{
		if (::World.getPlayerRoster().getSize() < 18)
		{
			return;
		}

		ws_create();
	}
	
	o.onUpdateEffect = function()
	{
		if (!this.m.DisableEffect)
		{
			::World.Assets.m.BrothersMaxInCombat = 22;
		}
	}
})