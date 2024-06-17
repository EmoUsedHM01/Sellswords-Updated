foreach (throw_skill in [
	"throw_axe",
	"throw_balls",
	"throw_javelin",
	"throw_spear_skill"
])
{
	::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/" + throw_skill, function( q )
	{	
		q.onAfterUpdate = @(__original) function( _properties )
		{
			__original( _properties );

			local actor = this.getContainer().getActor();
			if (actor.getCurrentProperties().isCloseCombatArcher)
			{
				this.m.MaxRange = 3;
			}
		}
	});
}
foreach (ranged_skill in [
	"shoot_bolt",
	"shoot_stake",
	"quick_shot",
	"sling_stone_skill"
])
{
	::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/" + ranged_skill, function( q )
	{	
		q.onAfterUpdate = @(__original) function( _properties )
		{
			__original( _properties );

			local actor = this.getContainer().getActor();
			if (actor.getCurrentProperties().isCloseCombatArcher)
			{
				this.m.MaxRange = 4;
			}
		}
	});
}