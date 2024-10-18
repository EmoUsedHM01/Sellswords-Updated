::Mod_Sellswords.HooksMod.hook("scripts/retinue/followers/alchemist_follower", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();
		this.m.Effects = [
			"Has a 25% chance of not consuming any crafting component used by you",
			"Unlocks \'Snake Oil\' recipe",
			"Allows you to refill bombs and flasks with ammunition"
		];
	}
});