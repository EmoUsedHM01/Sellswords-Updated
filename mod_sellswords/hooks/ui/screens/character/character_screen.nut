::Mod_Sellswords.HooksMod.hook("scripts/ui/screens/character/character_screen", function ( q ) {

	q.onDismissCharacter = @(__original) function( _data )
	{
		local origin = this.World.Assets.getOrigin();

		if (origin == null || origin.getID() != "scenario.gladiators")
			return __original(_data);

		local bro = this.Tactical.getEntityByID(_data[0]);

		if (bro != null && bro.getCurrentProperties().IsGladiator && origin.updateGladiators().len() <= 2)
		{
			this.loadData();
			return;
		}

		local ret = __original(_data);
		origin.updateGladiators();
		this.loadData();
		return ret;
	}

});
