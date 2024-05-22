::mods_hookExactClass("skills/perks/perk_debilitate", function ( o )
{
	o.onRemoved <- function ()
	{
		this.m.Container.removeByID("actives.debilitate");
	};
});