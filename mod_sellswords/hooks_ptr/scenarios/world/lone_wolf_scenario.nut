::mods_hookExactClass("scenarios/world/lone_wolf_scenario", function ( o )
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Difficulty = 3;
		this.m.RosterTierMax = this.Const.Roster.getTierForSize(20);			
	}	
	o.onBuildPerkTree <- function ( _background )
	{
		this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.PTRPersonalArmor);
	}		
});	