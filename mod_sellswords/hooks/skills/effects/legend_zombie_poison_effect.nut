::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_zombie_poison_effect", function ( q ) {

	q.onAdded = @(__original) function()
	{
		local actor = this.getContainer().getActor();
		local crrd = this.getContainer().hasSkill("perk.ssu_rangeddefense") ? this.Math.rand(1, 100) <= actor.getBaseProperties().RangedDefense : false;

		if (crrd)
		{
			this.removeSelf();
		}
		else
		{
			this.m.TurnsLeft = this.Math.max(1, 10 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		}

		if (this.getContainer().hasSkill("trait.ailing"))
		{
			++this.m.TurnsLeft;
		}
	};

	q.getTooltip = @(__original) function()
	{
		local nsed = this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration;
		local remaining = 10 - (this.m.TurnsLeft - nsed);
		local seriouslevel = this.getContainer().hasSkill("perk.ssu_resilient") ? 7.5 : 10;			
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
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.legend_zombie_poison_effect.Tooltip1, 1 * remaining)
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/vision.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.legend_zombie_poison_effect.Tooltip2, 1 * remaining)
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.legend_zombie_poison_effect.Tooltip3, seriouslevel * remaining)
			}
		];
	}

	q.onUpdate = @(__original) function( _properties )
	{
		local seriouslevel = this.getContainer().hasSkill("perk.ssu_resilient") ? 7.5 : 10;		
		local nsed = this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration;
		local AP = this.Math.max(1, 1 * (10 - (this.m.TurnsLeft - nsed)));
		local Init = this.Math.max(1, seriouslevel * (10 - (this.m.TurnsLeft - nsed)));
		local Vis = this.Math.max(1, 1 * (10 - (this.m.TurnsLeft - nsed)));
		_properties.ActionPoints -= AP;
		_properties.Initiative -= Init;
		_properties.Vision -= Vis;
	}		
});
