::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_sprint_skill", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 12;
	}

	q.isUsable = @( __original ) function()
	{
		return __original() && (!this.Tactical.isActive() || this.Const.DefaultMovementAPCost[this.getContainer().getActor().getTile().Type] <= 2);
	}

	q.onAfterUpdate <- function ( _properties )
	{
		local fat = this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]) * -1;
		this.m.FatigueCost = ::Math.min(22, this.m.FatigueCost + fat);	
		local frkz = this.getContainer().hasSkill("perk.crFurinkazan") && !this.getContainer().hasSkill("perk.legend_tumble");
		this.m.FatigueCostMult = _properties.IsFleetfooted || frkz ? 0.5 : 1.0;

		if (this.getContainer().getActor().getSkills().hasSkill("effects.goblin_grunt_potion") || frkz)
		{
			this.m.ActionPointCost = 2;
		}
	}	
});
