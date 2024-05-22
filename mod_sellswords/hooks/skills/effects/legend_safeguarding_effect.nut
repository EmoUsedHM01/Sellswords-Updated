::mods_hookExactClass("skills/effects/legend_safeguarding_effect", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.Description = "This character\'s guard is down while safeguarding";
	}

	o.onUpdate = function ( _properties )
	{
		// remove the downsides
	}

	o.getTooltip = function ()
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