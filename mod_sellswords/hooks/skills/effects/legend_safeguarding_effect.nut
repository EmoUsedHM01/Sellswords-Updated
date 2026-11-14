::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_safeguarding_effect", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Description = ::Mod_Sellswords.Strings.legend_safeguarding_effect.Description;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		// remove the downsides
	}

	q.getTooltip = @(__original) function()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}		
});
