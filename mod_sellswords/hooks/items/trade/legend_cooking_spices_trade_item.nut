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
				text = ::Mod_Sellswords.Strings.legend_cooking_spices_trade_item.Tooltip1
			});	
		}
		else
		{
			ret.push({
				id = 4,
				type = "text",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.legend_cooking_spices_trade_item.Tooltip2, this.m.Uses)
			});
		}

		return ret;
	}

	q.getValue = @(__original) function()
	{
		return __original() * 2.0;
	}

})