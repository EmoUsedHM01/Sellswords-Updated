::mods_hookExactClass("skills/actives/ptr_swordmaster_kick_skill", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.FatigueCost = 15;
	}
	
});