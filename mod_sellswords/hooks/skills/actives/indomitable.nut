::mods_hookExactClass("skills/actives/indomitable", function ( o )
{
	o.m.Islow <- false;
	
	o.getTooltip = function ()
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
				text = "Only receive [color=" + this.Const.UI.Color.PositiveValue + "]" + (100 - 50 * smc) + "%[/color] of any damage"
			},				
			{
				id = 6,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Base Resolve will be increased by [color=" + this.Const.UI.Color.PositiveValue + "]" + 100 * smc + "%[/color]"
			},				
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Become immune to being stunned"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Become immune to being knocked back or grabbed"
			}
		];
	};
});