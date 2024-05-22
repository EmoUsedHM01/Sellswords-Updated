this.banquet_item <- this.inherit("scripts/items/supplies/legend_usable_food", {
	m = {},
	function create()
	{
		this.legend_usable_food.create();
		this.m.ID = "supplies.banquet";
		this.m.Name = "Masterfully Banquet";
		this.m.Description = "Provisions. A meal that is well prepared and greatly enjoyed. The ideal provision to take with you on long journeys and expeditions. Can be eaten in battle to increase all of your combat attributes, based on amount of the food. Will be used as provisions if left in the company stash.";
		this.m.Icon = "supplies/inventory_provisions_17.png";
		this.m.Value = 400;
		this.m.Amount = 40.0;
		this.m.GoodForDays = 7;
		this.m.IsAllowedInBag = true;
		this.m.IsDroppedAsLoot = true;
	}

	function getBuyPrice()
	{
		if (this.m.IsSold)
		{
			return this.getSellPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			local isBuildingPresent = false;
			return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getPriceMult() * this.World.State.getCurrentTown().getFoodPriceMult() * this.World.State.getCurrentTown().getBuyPriceMult() * (isBuildingPresent ? this.Const.World.Assets.BaseBuyPrice : this.Const.World.Assets.BuyPriceNotProducedHere)));
		}

		return this.item.getBuyPrice();
	}

	function getSellPrice()
	{
		if (this.m.IsBought)
		{
			return this.getBuyPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			local isBuildingPresent = false;
			return this.Math.floor(this.getValue() * this.World.State.getCurrentTown().getFoodPriceMult() * this.World.State.getCurrentTown().getSellPriceMult() * (isBuildingPresent ? this.Const.World.Assets.BaseSellPrice : this.Const.World.Assets.SellPriceNotProducedHere));
		}

		return this.item.getSellPrice();
	}

	function onPutIntoBag()
	{
		this.onEquip();
	}

	function onEquip()
	{
		this.legend_usable_food.onEquip();
		local skill = this.new("scripts/skills/actives/legend_eat_porridge_skill");
		skill.setItem(this);
		skill.setAmount(this.m.Amount);
		this.addSkill(skill);
	}

});

