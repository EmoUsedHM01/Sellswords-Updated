::mods_hookExactClass("skills/perks/perk_ptr_tunnel_vision", function ( o )
{
	o.m.VisionBonus = 2;

	o.getTooltip = function()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.VisionBonus + "[/color] Vision"
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.SkillBonus + "[/color] Melee Skill"
		});		
		
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + 2 * this.m.SkillBonus + "[/color] Ranged Skill"
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.SkillBonus + "[/color] Melee Defense"
		});
		
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + 2 * this.m.SkillBonus + "[/color] Ranged Defense"
		});		
		
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.SkillBonus + "[/color] Bravery"
		});			

		return tooltip;
	}

	o.onUpdate = function ( _properties )
	{
		this.m.IsHidden = true;
		if (!this.World.getTime().IsDaytime && this.getContainer().getActor().isPlacedOnMap())
		{
			this.m.IsHidden = false;
			_properties.Vision += 2;			
			_properties.MeleeSkillMult *= 1.0 + this.m.SkillBonus / 100.0;
			_properties.MeleeDefenseMult *= 1.0 + this.m.SkillBonus / 100.0;
			_properties.RangedSkillMult *= 1.0 + this.m.SkillBonus / 100.0;
			_properties.RangedDefenseMult *= 1.0 + this.m.SkillBonus / 100.0;	
			_properties.BraveryMult *= 1.0 + this.m.SkillBonus / 100.0;			
		}
	}
});	