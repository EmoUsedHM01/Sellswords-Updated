::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_sprint_skill_5", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.FatigueCost = 16;
	}

	q.onAfterUpdate <- function ( _properties )
	{
		local fat = this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]) * -1;
		this.m.FatigueCost = ::Math.min(26, this.m.FatigueCost + fat);		
		local frkz = this.getContainer().hasSkill("perk.crFurinkazan");
		this.m.FatigueCostMult = _properties.IsFleetfooted || frkz ? 0.5 : 1.0;

		if (this.getContainer().getActor().getSkills().hasSkill("effects.goblin_grunt_potion") || frkz)
		{
			this.m.ActionPointCost = 4;
		}
	};		
});
