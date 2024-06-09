::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_drums_of_life_skill", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Description = "Push allies on with your music, restoring the health of all allies within 8 tiles by 8 hp. Must be holding a musical instrument to use.";
	}

});
