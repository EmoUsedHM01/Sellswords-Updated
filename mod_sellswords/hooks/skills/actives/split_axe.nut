::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/split_axe", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.DirectDamageMult = 0.35;
	}
});	