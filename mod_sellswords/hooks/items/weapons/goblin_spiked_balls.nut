::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/greenskins/goblin_spiked_balls", function( q )
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
		this.addSkill(this.new("scripts/skills/actives/bash_ranged"));
	}

	q.onAnySkillUsed = @( __original ) function( _skill, _targetEntity, _properties )
	{
		__original( _skill, _targetEntity, _properties );
	}
});
