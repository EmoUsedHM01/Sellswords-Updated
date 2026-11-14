::Mod_Sellswords.HooksMod.hook("scripts/items/accessory/legend_accessory_dog", function ( q ) {

	// a dog that is let loose when its handler dies gets the SSU hound bonuses as well
	q.onActorDied = @(__original) function( _onTile )
	{
		local before = this.m.Entity;
		local actor = this.getContainer().getActor();

		__original(_onTile);

		if (this.m.Entity != null && this.m.Entity != before)
		{
			::Mod_Sellswords.HookHelper.addHoundBonuses(actor, this.m.Entity);
		}
	}
});
