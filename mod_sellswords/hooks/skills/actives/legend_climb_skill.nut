::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_climb_skill", function ( q ) {

	q.onAfterUpdate = @( __original ) function ( _properties )
	{		
		local frkz = this.getContainer().hasSkill("perk.ssu_furinkazan");
		this.m.FatigueCostMult = _properties.IsFleetfooted || frkz ? 0.5 : 1.0;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_backflip"))
		{
			this.m.MaxRange = 2;
		}
		
		if (this.getContainer().hasSkill("effects.goblin_grunt_potion") || this.getContainer().hasSkill("effects.ssu_goblin_sequence") || frkz)
		{
			this.m.ActionPointCost = 2;
		}
	};		
});
