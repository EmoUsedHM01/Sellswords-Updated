::Mod_Sellswords.HooksMod.hook("scripts/scenarios/world/legends_sisterhood_scenario", function ( q ) {
	
	q.onBuildPerkTree = @(__original) function(_background)
	{
		this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.LegendRecuperation, 0, _background.isBackgroundType(this.Const.BackgroundType.Female));
	}
});
