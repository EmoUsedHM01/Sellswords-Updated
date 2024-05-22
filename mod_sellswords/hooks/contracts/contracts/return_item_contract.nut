::mods_hookExactClass("contracts/contracts/return_item_contract", function(o)
{
	o.start = function()
	{
		local crstrength = this.World.State.getPlayer().getStrength();
		crstrength = this.Math.min(50 * crstrength, 400);	
		this.m.Payment.Pool = crstrength * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		local items = [
			"Rare Coin Collection",
			"Ceremonial Staff",
			"Idol of Fertility",
			"Golden Talisman",
			"Tome of Arcane Knowledge",
			"Lockbox",
			"Demonic Statuette",
			"Crystal Skull"
		];
		local r = this.Math.rand(0, items.len() - 1);
		this.m.Flags.set("Item", items[r]);
		this.contract.start();
	}

	local ws_createStates = o.createStates;
	o.createStates = function()
	{
		ws_createStates();

		foreach (state in this.m.States)
		{
			if (state.ID != "Offer") continue;
			
			state.end = function()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local r = this.Math.rand(1, 100);

				if (r <= 15)
				{
					if (this.Contract.getDifficultyMult() >= 0.95)
					{
						this.Flags.set("IsNecromancer", true);
					}
				}
				else if (r <= 30)
				{
					this.Flags.set("IsCounterOffer", true);
					this.Flags.set("Bribe", this.Contract.beautifyNumber(this.Contract.m.Payment.getOnCompletion() * this.Math.rand(100, 300) * 0.01));
				}
				else
				{
					this.Flags.set("IsBandits", true);
				}

				this.Flags.set("StartDay", this.World.getTime().Days);
				local playerTile = this.World.State.getPlayer().getTile();
				local tile = this.Contract.getTileToSpawnLocation(playerTile, 5, 10, [
					this.Const.World.TerrainType.Mountains
				]);
				local party;
				local crstrength = this.World.State.getPlayer().getStrength();
				crstrength = this.Math.min(5 * crstrength, 80);
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).spawnEntity(tile, "Thieves", false, this.Const.World.Spawn.crthieves, crstrength * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.setDescription("A group of thieves and bandits.");
				party.setFootprintType(this.Const.World.FootprintsType.Brigands);
				party.setAttackableByAI(false);
				party.getController().getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
				party.setFootprintSizeOverride(0.75);
				this.Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party.getTile(), this.Const.GenericFootprints, this.Const.World.FootprintsType.Brigands, 0.75);
				this.Contract.m.Target = this.WeakTableRef(party);
				party.getSprite("banner").setBrush("banner_bandits_0" + this.Math.rand(1, 6));
				local c = party.getController();
				local wait = this.new("scripts/ai/world/orders/wait_order");
				wait.setTime(9000.0);
				c.addOrder(wait);
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

			break;
		}
	}
})