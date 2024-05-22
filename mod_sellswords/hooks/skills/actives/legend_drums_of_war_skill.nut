::mods_hookExactClass("skills/actives/legend_drums_of_war_skill", function(o) {
	
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.Description = "Push allies on with your music, lowering the fatigue of all allies within 8 tiles by 4 fatigue. Must be holding a musical instrument to use.";
	}

})