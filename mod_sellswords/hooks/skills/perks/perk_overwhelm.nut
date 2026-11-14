::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_overwhelm", function ( q ) {

	q.onAdded <- function ()
	{
		if (!this.m.Container.hasSkill("actives.ssu_overwhelm_attack") && this.getContainer().getActor().isPlayerControlled())
			this.m.Container.add(this.new("scripts/skills/actives/ssu_overwhelm_attack"));
	}

	q.onRemoved <- function ()
	{
		this.m.Container.removeByID("actives.ssu_overwhelm_attack");
	}

});