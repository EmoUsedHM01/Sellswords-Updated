::mods_hookExactClass("skills/effects/ptr_dented_armor_effect", function(o) {
	o.m.Count <- 1;

	o.getName <- function()
	{
		if (this.m.Count <= 1)
		{
			return this.m.Name;
		}
		else
		{
			return this.m.Name + " (x" + this.m.Count + ")";
		}
	}

	o.getTooltip = function()
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
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]+" + this.Math.min(3, this.m.Count) + "[/color] additional Action Points per tile moved"
			},			
			{
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Armor damage taken is increased by [color=" + this.Const.UI.Color.NegativeValue + "]+" + this.Math.min(30, 10 * this.m.Count) + "%[/color]"
			},			
		];
	}

	o.onRefresh <- function()
	{
		++this.m.Count;
		this.spawnIcon("ptr_dented_armor_effect", this.getContainer().getActor().getTile());
	}	

	o.onUpdate = function( _properties )
	{
		_properties.MovementAPCostAdditional += this.Math.min(3, this.m.Count);
		//_properties.FatigueEffectMult *= 1.0 + 0.1 * this.Math.min(3, this.m.Count);	
		_properties.DamageReceivedArmorMult *= 1.0 + 0.1 * this.Math.min(3, this.m.Count);		
	}
	
	o.onTurnStart <- function()
	{
		if (--this.m.Count <= 0)
		{
			this.removeSelf();
		}
	}
})