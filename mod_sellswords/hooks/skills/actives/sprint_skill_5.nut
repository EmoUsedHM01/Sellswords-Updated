::mods_hookExactClass("skills/actives/sprint_skill_5", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.FatigueCost = 16;
	}

	o.onAfterUpdate <- function ( _properties )
	{
		local fat = this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]) * -1;
		this.m.FatigueCost = ::Math.min(26, this.m.FatigueCost + fat);		
		local frkz = this.getContainer().hasSkill("perk.crFurinkazan") && !this.getContainer().hasSkill("perk.legend_tumble");
		this.m.FatigueCostMult = _properties.IsFleetfooted || frkz ? 0.5 : 1.0;

		if (this.getContainer().getActor().getSkills().hasSkill("effects.goblin_grunt_potion") || frkz)
		{
			this.m.ActionPointCost = 4;
		}
	};		
});