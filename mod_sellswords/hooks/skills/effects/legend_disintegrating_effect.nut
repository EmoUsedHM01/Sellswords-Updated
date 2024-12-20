::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_disintegrating_effect", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Damage = 33;
	}
});
