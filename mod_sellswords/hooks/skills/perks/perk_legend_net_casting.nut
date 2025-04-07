::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_net_casting", function ( q ) {

	q.onAdded <- function ()
	{
		this.m.Container.add(this.new("scripts/skills/actives/throw_net_free"));
	}

	q.onRemoved <- function ()
	{
		this.m.Container.removeByID("actives.throw_net_free");
	}

});
