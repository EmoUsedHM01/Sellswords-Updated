::Mod_Sellswords.HooksMod.hook("scripts/items/trade/legend_cooking_spices_trade_item", function ( q )  {
	
	q.create = @(__original) function()
	{
		__original();
		this.m.Uses = 4;
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
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

	q.getValue = @(__original) function()
	{
		return __original() * 2.0;
	}

})