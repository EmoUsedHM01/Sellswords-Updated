::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/adrenaline_skill", function ( q ) {	

	q.onAfterUpdate <- function ( _properties )
	{
		local rac = this.getContainer().getActor().getSkills().hasSkill("effects.crorcbehemoth_potion");

		if (rac)
		{
			this.m.FatigueCost = 8;
		}
	};
});
