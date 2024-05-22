::mods_hookExactClass("skills/perks/perk_ptr_bulwark", function ( o )
{
	o.getDescription <- function()
	{
		return "\'Not much to be afraid of behind a suit of plate!\'\n\n[color=" + this.Const.UI.Color.Passive + "][u]Passive:[/u][/color]\n• Resolve is increased by [color=" + this.Const.UI.Color.PositiveValue + "]2%[/color] of the combined current durability of head and body armor.\n• This bonus is [color=" + this.Const.UI.Color.PositiveValue + "]doubled[/color] against negative morale checks except mental attacks.\n• Hitpionts are increase by [color=" + this.Const.UI.Color.PositiveValue + "]2%[/color] of the combined maximum durability of head and body armor";
	}

	o.getTooltip = function()
	{
		local tooltip = this.skill.getTooltip();

		local bonus = this.getBonus();
		local bonusMax = this.getBonusMax();		
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Resolve"
		});
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/health.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonusMax + "[/color] Hitpoints"
		});		

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Resolve at negative morale checks except mental attacks"
		});

		return tooltip;
	}

	o.getBonus = function()
	{
		local armor = this.getContainer().getActor().getArmor(this.Const.BodyPart.Head) + this.getContainer().getActor().getArmor(this.Const.BodyPart.Body);			
		return this.Math.floor(armor * this.m.ArmorPercentageAsBonus * 0.01);
	}

	o.getBonusMax <- function()
	{
		local maxArmorDurability = this.getContainer().getActor().getArmorMax(this.Const.BodyPart.Head) + this.getContainer().getActor().getArmorMax(this.Const.BodyPart.Body);			
		return this.Math.floor(maxArmorDurability * this.m.ArmorPercentageAsBonus * 0.01);
	}

	local ws_onUpdate = o.onUpdate;
	o.onUpdate = function(_properties)
	{
		ws_onUpdate(_properties);
		_properties.Hitpoints += this.getBonusMax();		
	}
});	