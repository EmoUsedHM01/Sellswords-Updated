this.perk_crbeforethestorm <- this.inherit("scripts/skills/skill", {
	m = {
		isValid = false
	},
	function create()
	{
		this.m.ID = "perk.crbeforethestorm";
		this.m.Name = this.Const.Strings.PerkName.crbeforethestorm;
		this.m.Description = this.Const.Strings.PerkDescription.crbeforethestorm;
		this.m.Icon = "ui/perks/smackdown_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}
	
	function onUpdate( _properties )
	{
		if (this.m.isValid)
		{
			_properties.ActionPoints += 1;
			_properties.FatigueRecoveryRate += this.Math.floor(0.03 * this.getContainer().getActor().getFatigueMax());		
		}
	}	
		
	function onTurnEnd()
	{
		this.m.isValid = this.getContainer().getActor().getActionPoints() >= 1 ? true : false;
	}
	
	function onCombatFinished()
	{
		this.m.isValid = false;			
	}	
});

