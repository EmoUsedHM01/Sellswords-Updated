this.ssu_explore_treasures_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "ssu_explore_treasures_action";
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 12;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!_faction.isReadyForContract())
		{
			return;
		}
		
		if (_faction.getPlayerRelation() <= 75)
		{
			return;
		}

		// the idol is only ever taken to a camp near the town
		local barbarians = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians);

		if (barbarians == null)
		{
			return;
		}

		local homeTile = _faction.getSettlements()[0].getTile();
		local camp = barbarians.getNearestSettlement(homeTile);

		if (camp == null || homeTile.getDistanceTo(camp.getTile()) > ::Mod_Sellswords.TreasureCampDistance)
		{
			return;
		}

		if ((this.World.getTime().Days <= 80 && this.Math.rand(1, 100) > 10) || this.Math.rand(1, 100) > 20)
		{
			return;
		}

		this.m.Score = 1;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local contract = this.new("scripts/contracts/contracts/ssu_explore_treasures_contract");
		contract.setFaction(_faction.getID());
		contract.setHome(_faction.getSettlements()[0]);
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		this.World.Contracts.addContract(contract);
	}

});

