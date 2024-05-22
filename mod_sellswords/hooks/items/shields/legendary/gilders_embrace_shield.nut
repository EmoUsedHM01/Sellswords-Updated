::mods_hookExactClass("items/shields/legendary/gilders_embrace_shield", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()
		this.m.MeleeDefense = 28;
		this.m.RangedDefense = 28;
	}
	
});