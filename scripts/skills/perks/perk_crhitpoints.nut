this.perk_crhitpoints <- this.inherit("scripts/skills/skill", {
	m = {
	cof = 0.75
	},
	function create()
	{
		this.m.ID = "perk.crhitpoints";
		this.m.Name = this.Const.Strings.PerkName.crhitpoints;
		this.m.Description = this.Const.Strings.PerkDescription.crhitpoints;
		this.m.Icon = "ui/perks/crhitpoints.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.getContainer().getActor().getHitpointsPct() >= 0.99;
	}
	
	function getTooltip()
	{
		local ini = this.getContainer().getActor().getInitiative();	
		local currentPercent = this.getContainer().getActor().getHitpointsPct();
		currentPercent  = this.Math.floor((1 - this.m.cof * (1 - currentPercent)) * 100)
		local tooltip = this.skill.getTooltip();		

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Receives only [color=" + this.Const.UI.Color.PositiveValue + "]" + currentPercent + "%[/color] of any damage"
		});

		return tooltip;
	}	

	function onUpdate( _properties )
	{
		local currentPercent = this.getContainer().getActor().getHitpointsPct();	
		_properties.DamageReceivedTotalMult *= (1 - this.m.cof * (1 - currentPercent));
	}	

});

