::mods_hookExactClass("skills/traits/oath_of_valor_trait", function(o) {
	
	local ws_getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = ws_getTooltip();

		foreach (tooltip in ret)
		{
			if (tooltip.id == 11) continue;

			tooltip.text = "Will not flee in battle. while all attributes debuff cause by low morale will be [color=" + this.Const.UI.Color.PositiveValue + "]halved[/color]";
			break;
		}

		return ret;
	}

	o.onUpdate = function( _properties )
	{
		_properties.XPGainMult *= 0.75;	

		if (this.getContainer().getActor().getMoraleState() == this.Const.MoraleState.Wavering)
		{
			_properties.Bravery *= 1.06;
			_properties.RangedSkill *= 1.06;
			_properties.MeleeSkill *= 1.06;
			_properties.MeleeDefense *= 1.06;
			_properties.RangedDefense *= 1.06;			
		}

		if (this.getContainer().getActor().getMoraleState() == this.Const.MoraleState.Breaking)
		{
			_properties.Bravery *= 1.13;
			_properties.RangedSkill *= 1.13;
			_properties.MeleeSkill *= 1.13;
			_properties.MeleeDefense *= 1.13;
			_properties.RangedDefense *= 1.13;			
		}
		
	}	

})