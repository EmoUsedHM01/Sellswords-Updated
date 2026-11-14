this.ssu_player_levitate <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.ssu_player_levitate";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_player_levitate.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_player_levitate.Description;
		this.m.Icon = "ui/perks/legend_levitate.png";
		this.m.IconMini = "perk_37_mini";
		this.m.Overlay = "perk_37";
		this.m.IsRemovedAfterBattle = false;
		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = this.Const.LegendFlightMovementAPCost;
		actor.m.FatigueCosts = this.Const.LegendFlightMovementFatigueCost;
		actor.m.LevelActionPointCost = 0;
	}

	function onCombatFinished()
	{
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		actor.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		actor.m.LevelActionPointCost = this.Const.Movement.LevelDifferenceActionPointCost;
	}

});