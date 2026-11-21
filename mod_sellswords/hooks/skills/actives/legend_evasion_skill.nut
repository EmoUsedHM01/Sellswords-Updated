::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_evasion_skill", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 30;
	}

	q.onAfterUpdate <- function ( _properties )
	{
		local frkz = this.getContainer().hasSkill("perk.ssu_furinkazan");
		this.m.FatigueCostMult = _properties.IsFleetfooted || frkz ? 0.5 : 1.0;

		if (this.getContainer().hasSkill("effects.goblin_grunt_potion") || this.getContainer().hasSkill("effects.ssu_goblin_sequence") || frkz)
		{
			this.m.ActionPointCost = 3;
		}
	};
});
