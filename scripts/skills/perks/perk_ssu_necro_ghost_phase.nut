this.perk_ssu_necro_ghost_phase <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_necro_ghost_phase";
		this.m.Name = this.Const.Strings.PerkName.SsuNecroGhostPhase;
		this.m.Description = this.Const.Strings.PerkDescription.SsuNecroGhostPhase;
		this.m.Icon = "ui/perks/ssu_necro_ghost_phase.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.ssu_necro_ghost_phase"))
			this.m.Container.add(this.new("scripts/skills/actives/ssu_necro_ghost_phase_through"));
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.ssu_necro_ghost_phase");
	}

});