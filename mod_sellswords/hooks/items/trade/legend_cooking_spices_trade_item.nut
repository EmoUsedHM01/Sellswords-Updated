::mods_hookExactClass("items/trade/legend_cooking_spices_trade_item", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.Uses = 4;
	}

	local ws_getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = ws_getTooltip();
		ret.pop();

		if (this.m.Uses == 4)
		{
			ret.push({
				id = 4,
				type = "text",
				text = "Can be used in recipes 4 times"
			});	
		}
		else
		{
			ret.push({
				id = 4,
				type = "text",
				text = "Uses remaining: " + this.m.Uses + "/4"
			});
		}

		return ret;
	}

	local ws_getValue = o.getValue;
	o.getValue = function()
	{
		return ws_getValue() * 2.0;
	}

})