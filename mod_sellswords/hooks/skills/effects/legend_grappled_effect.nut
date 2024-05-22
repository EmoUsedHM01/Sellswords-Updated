::mods_hookExactClass("skills/effects/legend_grappled_effect", function ( o )
{
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
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15[/color] Fatigue recovered per turn"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-40%[/color] Maximum Fatigue"
			}
		];
	}	
	o.onUpdate = function ( _properties )
	{
		local actor = this.getContainer().getActor();
		_properties.StaminaMult *= 0.6;
		//_properties.MeleeDefense *= 0.5;
		_properties.FatigueRecoveryRate -= 15;

		if (!actor.hasSprite("status_stunned") && !this.getContainer().hasSkill("effects.stunned"))
		{
			actor.getSprite("status_stunned").setBrush("bust_dazed");
			actor.getSprite("status_stunned").Visible = true;
			actor.setDirty(true);
		}
	}		
});	