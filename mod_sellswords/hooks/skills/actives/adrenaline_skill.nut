::mods_hookExactClass("skills/actives/adrenaline_skill", function ( o )
{	
	o.onAfterUpdate <- function ( _properties )
	{
		local rac = this.getContainer().getActor().getSkills().hasSkill("effects.crorcbehemoth_potion");

		if (rac)
		{
			this.m.FatigueCost = 8;
		}
	};
});