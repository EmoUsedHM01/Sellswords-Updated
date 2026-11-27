::Mod_Sellswords.HooksMod.hook("scripts/ui/global/data_helper", function ( q ) {

	q.addCharacterToUIData = @(__original) function( _entity, _target )
	{
		__original(_entity, _target);

		if (_entity.getFlags().has("SsuGladiatorProtected"))
			_target.isPlayerCharacter = true;
	}

});
