::mods_hookExactClass("skills/actives/ptr_take_aim_skill", function(o) {
	
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 5;
	}

	local ws_isHidden = o.isHidden;
	o.isHidden = function()
	{
		return ws_isHidden() && !this.getContainer().hasSkill("actives.ignite_firelance");
	}

	o.getTooltip = function()
	{
		local tooltip = this.skill.getDefaultUtilityTooltip();

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "For ranged attacks in this turn:"
		});

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Crossbows ignore any hitchance penalty from obstacles, and the shot cannot go astray."
		});

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Handgonnes have their Maximum Range increased by 1 and if used at shorter range, have their area of effect increased by 1 instead."
		});
		
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Fire lances will have a 50% chance to disarm enemies when using Ignite."
		});		

		return tooltip;
	}

})