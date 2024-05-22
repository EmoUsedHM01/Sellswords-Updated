::mods_hookExactClass("skills/traits/old_trait", function(o) {
	
	local ws_getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = ws_getTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] Melee Damage"
		})

		return ret;
	}

	local ws_onUpdate = o.onUpdate;
	o.onUpdate = function( _properties )
	{
		ws_onUpdate(_properties);

		_properties.MeleeDamageMult *= 0.85;	
	}

})