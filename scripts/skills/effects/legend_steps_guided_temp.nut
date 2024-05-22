this.legend_steps_guided_temp <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.legend_steps_guided_temp";
		this.m.Name = "Steps guided";
		this.m.Description = "This character has been granted pathfinder by a talented ranger";
		this.m.Icon = "ui/perks/guided_steps_circle.png";
		this.m.IconMini = "mini_guided_steps_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = this.Const.PathfinderMovementAPCost;
		actor.m.FatigueCosts = clone this.Const.PathfinderMovementFatigueCost;
		actor.m.LevelActionPointCost = 0;
	}
	
	function onTurnEnd()
	{
		this.removeSelf();
	}	

});

