::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_underdog", function ( q ) {

	q.onUpdate = @( __original ) function ( _properties )
	{
		if (!this.getContainer().hasSkill("perk.legend_battleheart"))
		{
			_properties.SurroundedDefense += 5;
		}
	};
});
