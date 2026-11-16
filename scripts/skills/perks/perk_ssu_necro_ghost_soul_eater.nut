this.perk_ssu_necro_ghost_soul_eater <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_necro_ghost_soul_eater";
		this.m.Name = this.Const.Strings.PerkName.SsuNecroGhostSoulEater;
		this.m.Description = this.Const.Strings.PerkDescription.SsuNecroGhostSoulEater;
		this.m.Icon = "ui/perks/legend_draining_touch.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		if (_skill == null)
			return;

		local actor = this.getContainer().getActor();

		if (_targetEntity.getTile().getDistanceTo(actor.getTile()) > 2)
			return;

		local skills = [
			"actives.ghastly_touch",
			"actives.ssu_necro_ghost_phase",
			"actives.legend_banshee_scream"
		];

		if (skills.find(_skill.getID()) == null)
			return;

		if (this.Math.rand(1, 100) > 33)
			return;
		
		local NineLives = this.getContainer().getSkillByID("perk.nine_lives");

		if (NineLives != null)
		{
			if (!actor.isHiddenToPlayer())
				this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_ssu_necro_ghost_soul_eater.Log, this.Const.UI.getColorizedEntityName(actor), this.Const.UI.getColorizedEntityName(_targetEntity)));

			NineLives.addNineLivesCount();
		}
	}
});

