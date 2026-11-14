this.perk_ssu_necro_skeleton_reconstruction <- this.inherit("scripts/skills/skill", {
	m = {
		IsRightActor = false
	},
	function create()
	{
		this.m.ID = "perk.ssu_necro_skeleton_reconstruction";
		this.m.Name = this.Const.Strings.PerkName.SsuNecroSkeletonReconstruction;
		this.m.Description = this.Const.Strings.PerkDescription.SsuNecroSkeletonReconstruction;
		this.m.Icon = "ui/perks/ssu_necro_skeleton_reconstruction.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();

		if (this.isKindOf(actor.get(), "ssu_necro_undead_player"))
		{
			this.m.IsRightActor = true;
			actor.m.ChanceToTakeNoInjury = 100;
		}
	}

	function onRemoved()
	{
		if (this.m.IsRightActor)
			this.getContainer().getActor().m.ChanceToTakeNoInjury = 10;
	}

});