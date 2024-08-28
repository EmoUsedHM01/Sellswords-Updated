::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_overwhelm", function ( q ) {

	q.onAdded <- function ()
	{
		if (!this.m.Container.hasSkill("actives.cr_overwhelm_attack") && this.getContainer().getActor().isPlayerControlled())
			this.m.Container.add(this.new("scripts/skills/actives/cr_overwhelm_attack"));
	}

	q.onRemoved <- function ()
	{
		this.m.Container.removeByID("actives.cr_overwhelm_attack");
	}

});