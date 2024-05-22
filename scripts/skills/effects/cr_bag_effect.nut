this.cr_bag_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.cr_bag";
		this.m.Name = "Portabal Bag";
		this.m.Icon = "ui/perks/perk_20.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;		
		//this.m.IsHidden = true;
	}	

	function onUpdate( _properties )
	{
		if (!this.getContainer().hasSkill("perk.bags_and_belts"))
		{
			this.getContainer().getActor().getItems().setUnlockedBagSlots(3);
		}
	}
});

