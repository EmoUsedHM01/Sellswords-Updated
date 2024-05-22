::mods_hookExactClass("ai/world/orders/mercenary_order", function(o) {
	o.onExecute = function( _entity, _hasChanged )
	{
		if (this.m.TargetSettlement == null || this.m.TargetSettlement.isNull() || !this.m.TargetSettlement.isAlive())
		{
			this.getController().popOrder();
			return true;
		}

		if (this.m.TargetSettlement.getTile().ID != _entity.getTile().ID)
		{
			local move = this.new("scripts/ai/world/orders/move_order");
			move.setDestination(this.m.TargetSettlement.getTile());
			this.getController().addOrderInFront(move);
			return true;
		}

		_entity.setOrders("Getting Hired");
		_entity.clearTroops();
		local brush = _entity.getSprite("body").getBrush().Name;
		local r = this.Math.min(500 +  this.World.getTime().Days, 200 + 2 * this.World.getTime().Days);		
		this.Const.World.Common.assignTroops(_entity, this.Const.World.Spawn.MercenariesHIGH, this.Math.rand(r * 0.8, r * 1.2));
		_entity.getSprite("body").setBrush(brush);

		if (this.m.TargetSettlement.getFactions().len() == 1)
		{
			_entity.setFaction(this.m.TargetSettlement.getOwner().getID());
		}
		else
		{
			_entity.setFaction(this.m.TargetSettlement.getFactionOfType(this.Const.FactionType.Settlement).getID());
		}

		this.getController().popOrder();
		return true;
	}
});