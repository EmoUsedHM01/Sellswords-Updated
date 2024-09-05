this.ghost_boss_stats_changer <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "special.mod_ghost_boss_stats_changer";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.Type = ::Const.SkillType.Special;
		this.m.Order = ::Const.SkillOrder.First;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onUpdate( _properties )
	{
		_properties.InitiativeForTurnOrderAdditional += 9999;
	}

	function onTurnStart()
	{
		this.getContainer().getActor().recalculateStatsBasedOnPlayerParty();
		this.removeSelf();
	}

});