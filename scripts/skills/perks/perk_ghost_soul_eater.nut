this.perk_ghost_soul_eater <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ghost_soul_eater";
		this.m.Name = this.Const.Strings.PerkName.GhostSoulEater;
		this.m.Description = this.Const.Strings.PerkDescription.GhostSoulEater;
		this.m.Icon = "ui/perks/siphon_circle.png";
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
			"actives.ghost_phase",
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
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " feasts on the soul of " + this.Const.UI.getColorizedEntityName(_targetEntity));

			NineLives.addNineLivesCount();
		}
	}
});

