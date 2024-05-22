::mods_hookExactClass("skills/actives/ptr_kata_step_skill", function ( o )
{
	o.onAfterUpdate = function ( _properties )
	{
		this.m.FatigueCost = 0;
		this.m.ActionPointCost = 0;
		local actor = this.getContainer().getActor();

		if (actor.isPlacedOnMap())
		{
			local myTile = actor.getTile();

			if (myTile != null)
			{
				local ggp = actor.getSkills().hasSkill("effects.goblin_grunt_potion");

				if (ggp)
				{
					this.m.FatigueCost = this.Math.max(0, actor.getFatigueCosts()[myTile.Type] * 0.5 * _properties.MovementFatigueCostMult);
					this.m.ActionPointCost = this.Math.max(0, (actor.getActionPointCosts()[myTile.Type] - 3) * _properties.MovementAPCostMult);
				}
				else
				{
					this.m.FatigueCost = this.Math.max(0, actor.getFatigueCosts()[myTile.Type] * _properties.MovementFatigueCostMult);
					this.m.ActionPointCost = this.Math.max(0, (actor.getActionPointCosts()[myTile.Type] - 2) * _properties.MovementAPCostMult);
				}
			}
		}
	};
});