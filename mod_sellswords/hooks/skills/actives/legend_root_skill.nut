::mods_hookExactClass("skills/actives/legend_root_skill", function ( o )
{
	o.getTooltip <- function ()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getMaxRange() + "[/color] tiles"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Some targets can never be caught or ensnared"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Cost will reduce if you have Stave Mastery"
			}				
		]);
		return ret;
	}	
	o.onAfterUpdate = function ( _properties )
	{
		this.m.FatigueCost = _properties.IsSpecializedInStaves ? 15 : 20;
		this.m.ActionPointCost = _properties.IsSpecializedInStaves ? 5 : 6;
		if (this.getContainer().hasSkill("special.legend_rain"))
		{
			this.m.FatigueCost -= 10;
			this.m.ActionPointCost -= 1;
		}
	}
});		