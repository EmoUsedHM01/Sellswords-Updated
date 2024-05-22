::mods_hookExactClass("skills/perks/perk_ptr_vigilant", function ( o )
{
	o.getTooltip = function ()
	{
		local tooltip = this.skill.getTooltip();
		local actor = this.getContainer().getActor();
		local cof = this.Math.max(1, (1 - actor.getFatigue() / actor.getFatigueMax()) * 4);
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.Bonus * cof * 0.5 + "[/color] Melee Defense"
		});
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.Bonus * cof * 0.5 + "[/color] Ranged Defense"
		});
		return tooltip;
	};
	o.onUpdate = function ( _properties )
	{
		local actor = this.getContainer().getActor();
		local cof = this.Math.max(1, (1 - actor.getFatigue() / actor.getFatigueMax()) * 4);
		_properties.RangedDefense += this.m.Bonus * cof * 0.5;
		_properties.MeleeDefense += this.m.Bonus * cof * 0.5;
	};
});