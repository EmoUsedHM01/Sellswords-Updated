::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/indomitable_effect", function ( q ) {

	q.m.Islow <- false;
	q.getTooltip = @(__original) function()
	{
		local smc = 1;
		if (this.m.Islow)
		{
			smc = 0.5;
		}		
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
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.indomitable_effect.Tooltip1, (100 - 50 * smc))
			},				
			{
				id = 6,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.indomitable_effect.Tooltip2, 100 * smc)
			},				
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.indomitable_effect.Tooltip3
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.indomitable_effect.Tooltip4
			}
		];
	}

	q.onUpdate = @(__original) function( _properties )
	{
		local smc = 1;
		if (this.m.Islow)
		{
			smc = 0.5;
		}
		_properties.DamageReceivedTotalMult *= (1 - 0.5 * smc);
		_properties.IsImmuneToStun = true;
		_properties.IsImmuneToKnockBackAndGrab = true;
		_properties.TargetAttractionMult *= 0.5;
		_properties.Bravery += this.getContainer().getActor().getBaseProperties().getBravery() * smc;
	};
});
