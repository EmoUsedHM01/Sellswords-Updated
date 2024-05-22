::mods_hookExactClass("skills/effects/zombie_poison_effect", function ( o )
{
	o.onAdded = function ()
	{
		local actor = this.getContainer().getActor();
		local crrd = this.getContainer().hasSkill("perk.crrangeddefense") ? this.Math.rand(1, 100) <= actor.getBaseProperties().RangedDefense : false;

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
	o.getTooltip = function ()
	{
		local nsed = this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration;
		local remaining = 10 - (this.m.TurnsLeft - nsed);
		local seriouslevel = this.getContainer().hasSkill("perk.crresilient") ? 7.5 : 10;			
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
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + 1 * remaining + "[/color] Action Points"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + 1 * remaining + "[/color] Vision"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + seriouslevel * remaining + "[/color] Initiative"
			}
		];
	}
	o.onUpdate = function ( _properties )
	{
		local seriouslevel = this.getContainer().hasSkill("perk.crresilient") ? 7.5 : 10;		
		local nsed = this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration;
		local AP = this.Math.max(1, 1 * (10 - (this.m.TurnsLeft - nsed)));
		local Init = this.Math.max(1, seriouslevel * (10 - (this.m.TurnsLeft - nsed)));
		local Vis = this.Math.max(1, 1 * (10 - (this.m.TurnsLeft - nsed)));
		_properties.ActionPoints -= AP;
		_properties.Initiative -= Init;
		_properties.Vision -= Vis;
	}		
});