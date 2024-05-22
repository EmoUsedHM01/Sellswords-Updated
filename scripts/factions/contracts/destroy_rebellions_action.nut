this.destroy_rebellions_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Location = null
	},
	function create()
	{
		this.m.ID = "destroy_rebellions_action";
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
		
		if (_faction.getPlayerRelation() <= 50)
		{
			return;
		}		

		if (this.Math.rand(1, 100) > 13)
		{
			return;
		}

		this.m.Location = null;

		foreach( a in _faction.getSettlements()[0].getAttachedLocations() )
		{
			if (!a.isMilitary() && a.isUsable() && a.getTile().getDistanceTo(_faction.getSettlements()[0].getTile()) >= 3)
			{
				this.m.Location = a;
				break;
			}
		}

		if (this.m.Location == null)
		{
			return;
		}
		
		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}		

		this.m.Score = 1;
	}

	function onClear()
	{
		this.m.Location = null;
	}

	function onExecute( _faction )
	{
		local contract = this.new("scripts/contracts/contracts/destroy_rebellions_contract");
		contract.setFaction(_faction.getID());
		contract.setHome(_faction.getSettlements()[0]);		
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		this.World.Contracts.addContract(contract);
	}

});

