::mods_hookExactClass("items/accessory/legend_hexen_ichor_potion_item", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.Description = "A disgusting Hexen brew, will grants user perfect focus, halving the action point costs of all skills for three turns.";
		this.m.Value = 2000;
	}

});	