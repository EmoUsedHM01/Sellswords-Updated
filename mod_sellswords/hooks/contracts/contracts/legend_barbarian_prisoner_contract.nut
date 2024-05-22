::mods_hookExactClass("contracts/contracts/legend_barbarian_prisoner_contract", function(o)
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.MinStrength = 500;
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
				this.Contract.spawnCaravan();
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
				this.World.State.setCampingAllowed(false);

				if (this.Contract.m.BarbCampTile == null || this.Contract.m.BarbCampTile.IsOccupied)
				{
					local playerTile = this.World.State.getPlayer().getTile();
					this.Contract.m.BarbCampTile = this.Contract.getTileToSpawnLocation(playerTile, 6, 12, [
						this.Const.World.TerrainType.Shore,
						this.Const.World.TerrainType.Ocean,
						this.Const.World.TerrainType.Mountains
					], false);
				}

				local tile = this.Contract.m.BarbCampTile;
				tile.clear();
				this.Contract.m.BarbCamp = this.WeakTableRef(this.World.spawnLocation("scripts/entity/world/locations/barbarian_camp_location", tile.Coords));
				this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians).addSettlement(this.Contract.m.BarbCamp.get(), false);
				this.Contract.m.BarbCamp.setBanner("banner_wildmen_01");
				this.Contract.m.BarbCamp.getSprite("location_banner").Visible = true;
				this.Contract.m.BarbCamp.setName(this.Flags.get("BarbCampName"));
				this.Contract.m.BarbCamp.setDiscovered(false);
				this.Contract.m.BarbCamp.clearTroops();
				this.Contract.m.BarbCamp.getLoot().clear();
				this.Contract.addUnitsToEntity(this.Contract.m.BarbCamp, this.Const.World.Spawn.BarbariansArmy, 200 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.BarbCamp.setResources(this.Math.min(this.Contract.m.BarbCamp.getResources(), 200 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
				this.Contract.m.BarbCamp.setLootScaleBasedOnResources(200 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.BarbCamp.updateStrength();
				local party;
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians).spawnEntity(this.Contract.m.BarbCamp.getTile(), "Barbarian Retaliation", false, this.Const.World.Spawn.BarbariansArmy, 200 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.getSprite("banner").setBrush(this.Contract.m.BarbCamp.getBanner());
				party.setAttackableByAI(false);
				this.Contract.m.BarbRetal = this.WeakTableRef(party);
				local c = party.getController();
				local intercept = this.new("scripts/ai/world/orders/intercept_order");
				intercept.setTarget(this.World.State.getPlayer());
				c.addOrder(intercept);
				c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
				c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(true);
				party.setDescription("These savages would like to have their buddy back.");
				party.setMovementSpeed(this.Const.World.MovementSettings.Speed * 1.4);
				party.getLoot().Money = this.Math.rand(150, 500);
				party.getLoot().ArmorParts = this.Math.rand(0, 20);
				party.getLoot().Medicine = this.Math.rand(0, 10);
				party.getLoot().Ammo = this.Math.rand(0, 15);
				this.Contract.m.BarbCamp.getSprite("selection").Visible = false;
				this.Contract.m.BarbRetal.getSprite("selection").Visible = false;
			}
		}
	}
})