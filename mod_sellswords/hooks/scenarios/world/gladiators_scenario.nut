::Mod_Sellswords.HooksMod.hook("scripts/scenarios/world/gladiators_scenario", function ( q ) {

	q.m.IsEndEventDone <- false;

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = ::Mod_Sellswords.Strings.gladiators_scenario.Description;
	}
	
	q.onBuildPerkTree <- function( _background )
	{
		this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.LegendThrowSand, 0);
	}

	q.addGladiatorTrait <- function( _bro )
	{
		local background = _bro.getBackground();

		if (background == null || !::isKindOf(background, "gladiator_background") || _bro.getCurrentProperties().IsGladiator)
			return;

		local traits = [
			"glorious_endurance_trait",
			"glorious_quickness_trait",
			"glorious_resolve_trait",
			"ssu_gladiator_kraken_trait",
			"ssu_gladiator_wolf_trait",
			"ssu_gladiator_scorpion_trait",
			"ssu_gladiator_hornet_trait"
		];
		_bro.getSkills().add(this.new("scripts/skills/traits/" + traits[this.Math.rand(0, traits.len() - 1)]));
	}

	q.onGenerateBro <- function( _bro )
	{
		this.addGladiatorTrait(_bro);
	}

	q.onHiredByScenario <- function( _bro )
	{
		this.addGladiatorTrait(_bro);
	}

	q.onCombatFinished = @(__original) function()
	{
		local gladiators = [];

		foreach (bro in this.World.getPlayerRoster().getAll())
		{
			if (bro.getCurrentProperties().IsGladiator)
				gladiators.push(bro);
		}

		// the last two can't be dismissed and don't desert
		foreach (bro in gladiators)
		{
			if (gladiators.len() <= 2)
				bro.getFlags().add("IsPlayerCharacter", true);
			else
				bro.getFlags().remove("IsPlayerCharacter");
		}

		if (gladiators.len() >= 2)
			return true;

		if (gladiators.len() == 0 || this.m.IsEndEventDone)
			return false;

		if (this.World.Events.canFireEvent(true, true))
			this.World.Events.fire("event.ssu_gladiators_end");

		return true;
	}
});
