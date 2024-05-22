this.cr_fragile_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.cr_fragile";
		this.m.Name = "Fragile";
		this.m.Description = "This character is fragile cause after reciving an attack to his weakness.";
		this.m.Icon = "ui/perks/ptr_wear_them_down.png";
		this.m.IconMini = "ptr_worn_down_effect_mini";
		this.m.Overlay = "ptr_worn_down_effect";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color] Melee Defense"
		});
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color] Ranged Defense"
		});
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color] Resolve"
		});		

		return tooltip;
	}

	function onUpdate( _properties )
	{
		if (!this.isGarbage())
		{
			_properties.MeleeDefenseMult *= 0.8;
			_properties.RangedDefenseMult *= 0.8;		
			_properties.BraveryMult *= 0.8;	
		}
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}
});
