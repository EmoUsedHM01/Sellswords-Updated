this.perk_ssu_bravery <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_bravery";
		this.m.Name = this.Const.Strings.PerkName.SsuBravery;
		this.m.Description = this.Const.Strings.PerkDescription.SsuBravery;
		this.m.Icon = "ui/perks/ssu_bravery.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	
	function onUpdate( _properties )
	{
		if (this.getContainer().getActor().getMoraleState() == this.Const.MoraleState.Wavering)
		{
			_properties.Bravery *= 1.22;
			_properties.RangedSkill *= 1.22;
			_properties.MeleeSkill *= 1.22;
			_properties.MeleeDefense *= 1.22;
			_properties.RangedDefense *= 1.22;			
		}

		if (this.getContainer().getActor().getMoraleState() == this.Const.MoraleState.Breaking)
		{
			_properties.Bravery *= 1.38;
			_properties.RangedSkill *= 1.38;
			_properties.MeleeSkill *= 1.38;
			_properties.MeleeDefense *= 1.38;
			_properties.RangedDefense *= 1.38;			
		}
		
		if (this.getContainer().getActor().getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			_properties.Bravery *= 1.57;
			_properties.RangedSkill *= 1.57;
			_properties.MeleeSkill *= 1.57;
			_properties.MeleeDefense *= 1.57;
			_properties.RangedDefense *= 1.57;			
		}		
		
	}	

});

