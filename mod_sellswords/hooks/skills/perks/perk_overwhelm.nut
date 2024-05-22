::mods_hookExactClass("skills/perks/perk_overwhelm", function ( o )
{
	o.onAdded <- function ()
	{
		if (!this.m.Container.hasSkill("actives.cr_overwhelm_attack") && this.getContainer().getActor().isPlayerControlled())
		{
			this.m.Container.add(this.new("scripts/skills/actives/cr_overwhelm_attack"));
		}
	};
	o.onRemoved <- function ()
	{
		this.m.Container.removeByID("actives.cr_overwhelm_attack");
	};
});