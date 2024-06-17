::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/named/named_javelin", function( q )
{
	q.onAfterUpdate <- function( _properties )
	{	
		local actor = this.getContainer().getActor();
		if (actor.getCurrentProperties().isCloseCombatArcher)
		{
			this.m.MaxRange = 3;
			this.m.MinRange = 1;
		}
	}

	q.onEquip = @( __original ) function()
	{
		__original();
		local skillToAdd = this.new("scripts/skills/actives/thrust_ranged");
	}
});
