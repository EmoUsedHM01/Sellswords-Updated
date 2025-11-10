::Mod_Sellswords.HooksMod.hook("scripts/ambitions/oaths/oath_of_camaraderie_ambition", function ( q ) {

	q.create = @( __original ) function()
	{
		__original();
		this.m.OathBoonText = "You can take up to [color=%positive%]18[/color] men into battle.";
	}

	q.onUpdateScore = @( __original ) function()
	{
		if (::World.getPlayerRoster().getSize() < 18)
		{
			return;
		}

		__original();
	}
	
	q.onUpdateEffect = @( __original) function()
	{
		if (!this.m.DisableEffect)
		{
			::World.Assets.m.BrothersMaxInCombat = 22;
		}
	}
});
