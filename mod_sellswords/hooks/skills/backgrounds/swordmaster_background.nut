::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/swordmaster_background", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.HiringCost = 1000;
	}
});
