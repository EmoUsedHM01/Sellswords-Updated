::mods_hookExactClass("skills/backgrounds/swordmaster_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.HiringCost = 1000;
	}
});