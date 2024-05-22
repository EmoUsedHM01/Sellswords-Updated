::mods_hookExactClass("skills/effects/ptr_smackdown_debuff_effect", function ( o )
{
	o.m.TurnsLeft <- 2;
	function getTooltip()
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
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]+" + 2 + "%[/color] Action Points less usable"
			}
		];
	}
	o.onUpdate = function ( _properties )
	{
		if (this.getContainer().getActor().getSkills().hasSkill("effects.staggered"))
		{
			_properties.ActionPoints -= 2;
		}
	}
	o.onTurnEnd = function ()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}		
});	