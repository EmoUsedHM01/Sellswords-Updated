::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_net_casting", function ( q ) {

	q.onAdded <- function ()
	{
		this.m.Container.add(this.new("scripts/skills/actives/throw_net_free"));
	}

	q.onRemoved <- function ()
	{
		this.m.Container.removeByID("actives.throw_net_free");
	}

	q.getItemActionCost = @( __original ) function ( _items )
	{
		local nets = 0;
		local notNets = 0;
		foreach (item in _items)
		{
			if (item != null)
			{
				if (item.getID().find("throwing_net") != null)
					nets += 1;
				else
					notNets += 1;
			} 
		}

		// Equipping a net into a free offhand (whether from the bag or from the ground) is always free
		if (_items.len() == 3 && nets == 1 && notNets == 0)
			return 0;

		return null;
	}

});