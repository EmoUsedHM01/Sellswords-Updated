this.perk_ssu_initiative <- this.inherit("scripts/skills/skill", {
	m = {
		IsWait = false,
		Afterwait = 1,		
	},
	function create()
	{
		this.m.ID = "perk.ssu_initiative";
		this.m.Name = this.Const.Strings.PerkName.SsuInitiative;
		this.m.Description = this.Const.Strings.PerkDescription.SsuInitiative;
		this.m.Icon = "ui/perks/ssu_initiative.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	
	function getTooltip()
	{
		local ini = this.Math.floor(this.m.Afterwait);		
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_ssu_initiative.Tooltip, ini)
		});

		return tooltip;
	}	

	function onUpdate( _properties )
	{
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

