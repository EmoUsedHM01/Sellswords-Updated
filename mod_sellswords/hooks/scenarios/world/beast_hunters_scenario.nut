::Mod_Sellswords.HooksMod.hook("scripts/scenarios/world/beast_hunters_scenario", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = ::Mod_Sellswords.Strings.beast_hunters_scenario.Description;
	}

	q.onInit = @(__original) function()
	{
		__original();
		this.World.Assets.m.BuyPriceMult = 1.1;
		this.World.Assets.m.SellPriceMult = 0.9;
	}
	
	q.onBuildPerkTree = @(__original) function(_background)
	{
		this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.LegendEscapeArtist);
	}
});
