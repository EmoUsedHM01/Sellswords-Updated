::Mod_Sellswords.HooksMod.hook("scripts/retinue/followers/alchemist_follower", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();
		this.m.Effects.push("Allows you to refill bombs and flasks with ammunition");
	}
});