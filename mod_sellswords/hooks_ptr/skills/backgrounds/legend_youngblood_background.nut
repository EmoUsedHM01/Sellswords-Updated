::mods_hookExactClass("skills/backgrounds/legend_youngblood_background", function ( o )
{
	o.getTooltip = function ()
	{
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Resolve at morale checks against fear, panic or mind control effects. Also knows how to craft wooden stakes for use against vampires."
		});
		ret.push({		
			id = 13,
			type = "text",
			icon = "ui/icons/xp_received.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] Experience Gain"
		});
		return ret;
	}	
});	