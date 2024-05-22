this.crbonebreaker_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Count = 1
	},
			
	function create()
	{
		this.m.ID = "effects.crbonebreaker";
		this.m.Name = "Fractured";
		this.m.Icon = "ui/perks/ptr_bone_breaker.png";
		this.m.IconMini = "crBonebreaker_mini";
		this.m.Overlay = "crBonebreaker_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;		
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = false;		
	}

	function getName()
	{
		return this.m.Name + " (x" + this.m.Count + ")";
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/health.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.Count * 8 + "%[/color] Max Hitpoints"
		});		

		return tooltip;
	}

	function onUpdate( _properties )
	{
		if (this.m.Count > 5)
		{
			this.m.Count = 5;
		}

		_properties.HitpointsMult *= 1.0 - this.m.Count * 0.08;	
		//_properties.DamageReceivedTotalMult *= 1.0 + this.m.Count / 10.0;
	}

	function onRefresh()
	{
		if (this.m.Count < 5)
		{
			++this.m.Count;
		}
	}
	
});

