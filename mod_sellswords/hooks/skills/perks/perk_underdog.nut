::mods_hookExactClass("skills/perks/perk_underdog", function ( o )
{
	o.onUpdate = function ( _properties )
	{
		if (!this.getContainer().hasSkill("perk.legend_battleheart"))
		{
			_properties.SurroundedDefense += 5;
		}
	};
});