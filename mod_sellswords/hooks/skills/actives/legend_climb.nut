::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_climb", function ( q ) {

	q.onAfterUpdate = @( __original ) function ( _properties )
	{		
		local frkz = this.getContainer().hasSkill("perk.crFurinkazan") && !this.getContainer().hasSkill("perk.legend_tumble");
		this.m.FatigueCostMult = _properties.IsFleetfooted || frkz ? 0.5 : 1.0;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_backflip"))
		{
			this.m.MaxRange = 2;
		}
		
		if (this.getContainer().getActor().getSkills().hasSkill("effects.goblin_grunt_potion") || frkz)
		{
			this.m.ActionPointCost = 2;
		}
	};		
});
