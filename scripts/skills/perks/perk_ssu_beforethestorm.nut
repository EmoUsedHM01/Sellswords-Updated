this.perk_ssu_beforethestorm <- this.inherit("scripts/skills/skill", {
	m = {
		isValid = false
	},
	function create()
	{
		this.m.ID = "perk.ssu_beforethestorm";
		this.m.Name = this.Const.Strings.PerkName.SsuBeforethestorm;
		this.m.Description = this.Const.Strings.PerkDescription.SsuBeforethestorm;
		this.m.Icon = "ui/perks/legend_smackdown.png";
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

