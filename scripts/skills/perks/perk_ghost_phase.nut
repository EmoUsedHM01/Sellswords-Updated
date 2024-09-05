this.perk_ghost_phase <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ghost_phase";
		this.m.Name = this.Const.Strings.PerkName.GhostPhase;
		this.m.Description = this.Const.Strings.PerkDescription.GhostPhase;
		this.m.Icon = "ui/perks/perk_ghost_phase.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.ghost_phase"))
			this.m.Container.add(this.new("scripts/skills/actives/mod_ghost_phase_through"));
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.ghost_phase");
	}

});