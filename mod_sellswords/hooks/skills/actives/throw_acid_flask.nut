::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/throw_acid_flask", function ( q ) {
	
	q.isHidden <- function()
	{
		return this.getContainer().getActor().getCurrentProperties().IsSpecializedInNets;
	}

});
