::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/unleash_wardog", function ( q ) {

	// adds the SSU hound bonuses on top of what Legends gives the animal
	q.addAnimalSkills = @( __original ) function ( _entity )
	{
		__original(_entity);

		::Mod_Sellswords.HookHelper.addHoundBonuses(this.getContainer().getActor(), _entity);
	}
});
