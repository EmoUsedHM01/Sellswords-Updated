this.ssu_steps_guided_temp <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.ssu_steps_guided_temp";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_steps_guided_temp.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_steps_guided_temp.Description;
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
		this.skill.onTurnEnd();
		this.removeSelf();
	}	

});

