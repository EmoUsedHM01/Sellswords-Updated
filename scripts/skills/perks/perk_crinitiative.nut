this.perk_crinitiative <- this.inherit("scripts/skills/skill", {
	m = {
		IsWait = false,
		Afterwait = 1,		
	},
	function create()
	{
		this.m.ID = "perk.crinitiative";
		this.m.Name = this.Const.Strings.PerkName.crinitiative;
		this.m.Description = this.Const.Strings.PerkDescription.crinitiative;
		this.m.Icon = "ui/perks/crinitiative.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	
	function getTooltip()
	{
		//local ini = this.Math.max(0, this.getContainer().getActor().getBaseProperties().Initiative);	
		local ini = this.Math.floor(this.m.Afterwait);		
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Use [color=" + this.Const.UI.Color.PositiveValue + "]" + ini + "[/color] Initiative for determining turn order"
		});

		return tooltip;
	}	

	function onUpdate( _properties )
	{
		//local ini = this.getContainer().getActor().getBaseProperties().Initiative;
		//_properties.InitiativeForTurnOrderAdditional += this.Math.max(0, ini);
		_properties.InitiativeForTurnOrderMult *= 2;
		this.m.Afterwait = this.getContainer().getActor().getInitiative() * (this.m.IsWait ? _properties.InitiativeAfterWaitMult : 1) * _properties.InitiativeForTurnOrderMult;		
	}

	function onTurnStart()
	{
		this.m.IsWait = false;
	}	
	
	function onWaitTurn()
	{
		this.m.IsWait = true;
	}		
	
});

