this.perk_skeleton_reconstruction <- this.inherit("scripts/skills/skill", {
	m = {
		IsRightActor = false
	},
	function create()
	{
		this.m.ID = "perk.skeleton_reconstruction";
		this.m.Name = this.Const.Strings.PerkName.SkeletonReconstruction;
		this.m.Description = this.Const.Strings.PerkDescription.SkeletonReconstruction;
		this.m.Icon = "ui/perks/perk_skeleton_reconstruction.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	/*function onUpdate( _properties )
	{
		properties.Hitpoints += 10;
	}*/

	function onAdded()
	{
		local actor = this.getContainer().getActor();

		if (this.isKindOf(actor.get(), "undead_player"))
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