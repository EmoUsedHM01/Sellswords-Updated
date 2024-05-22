::mods_hookExactClass("items/shields/named/named_shield", function(o) {
	o.m.IsAllowedRandomizeValues <- true;

	local ws_randomizeValues = o.randomizeValues;
	o.randomizeValues = function()
	{
		if (!this.m.IsAllowedRandomizeValues) return;

		ws_randomizeValues();
	}
})