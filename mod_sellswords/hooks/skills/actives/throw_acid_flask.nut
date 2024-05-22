::mods_hookExactClass("skills/actives/throw_acid_flask", function(o) {
	
	o.isHidden <- function()
	{
		return this.getContainer().getActor().getCurrentProperties().IsSpecializedInNets;
	}

})