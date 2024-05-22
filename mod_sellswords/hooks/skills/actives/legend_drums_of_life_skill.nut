::mods_hookExactClass("skills/actives/legend_drums_of_life_skill", function(o) {
	
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.Description = "Push allies on with your music, restoring the health of all allies within 8 tiles by 8 hp. Must be holding a musical instrument to use.";
	}

})