this.perk_ssu_hitpoints <- this.inherit("scripts/skills/skill", {
	m = {
	cof = 0.75
	},
	function create()
	{
		this.m.ID = "perk.ssu_hitpoints";
		this.m.Name = this.Const.Strings.PerkName.SsuHitpoints;
		this.m.Description = this.Const.Strings.PerkDescription.SsuHitpoints;
		this.m.Icon = "ui/perks/ssu_hitpoints.png";
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
		currentPercent  = this.Math.floor((1 - this.m.cof * (1 - currentPercent)) * 100);
		local tooltip = this.skill.getTooltip();		

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_ssu_hitpoints.Tooltip, currentPercent)
		});

		return tooltip;
	}	

	function onUpdate( _properties )
	{
		local currentPercent = this.getContainer().getActor().getHitpointsPct();	
		_properties.DamageReceivedTotalMult *= (1 - this.m.cof * (1 - currentPercent));
	}	

});

