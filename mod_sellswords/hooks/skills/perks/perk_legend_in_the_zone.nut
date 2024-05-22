::mods_hookExactClass("skills/perks/perk_legend_in_the_zone", function ( o )
{
	o.m.MaxStacks = 20;
	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local tooltip = this.skill.getTooltip();
		local bonus = this.getBonus();
		local crbonus = this.getBonus();     
		local actor = this.getContainer().getActor();

		if (bonus > 0)
		{
			if (actor.isPlacedOnMap() && ::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1, true).len() > 0)		//engaged	  	
			{
				bonus = bonus * 2;			//melee damage		
				crbonus *= 0;              //melee attack
			}

			if (crbonus > 0)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + crbonus + "%[/color] Melee Skill"
				});
			}

			if (crbonus == 0)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 0.5 * bonus + "%[/color] Melee Defense"
				});
			}

			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + bonus + "%[/color] Melee Damage"
			});
		}

		if (!actor.isPlacedOnMap() || ::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1, true).len() == 0)		//not engaged		
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Melee Damage bonus [color=" + this.Const.UI.Color.NegativeValue + "]halved[/color] due to not being engaged in melee"
			});
		}

		return tooltip;
	};
	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties )
	{
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap())
		{
			this.m.Stacks = 0;
			local armorFat = actor.getItems().getStaminaModifier([
				::Const.ItemSlot.Body,
				::Const.ItemSlot.Head
			]) * -1;

			if (actor.getInitiative() >= 2 * armorFat)
			{
				this.m.Stacks = this.Math.min(this.m.MaxStacks, this.Math.max(0, armorFat - 15));
			}
		}
		
		if (!actor.isPlayerControlled() && this.Time.getRound() == 1)
		{
			local armorFat = actor.getItems().getStaminaModifier([
				::Const.ItemSlot.Body,
				::Const.ItemSlot.Head
			]) * -1;			
			this.m.Stacks = this.Math.min(this.m.MaxStacks, this.Math.max(0, armorFat - 15));
		}			

		if (this.m.Stacks > 0)
		{
			local bonus = this.getBonus();
			local crbonus = this.getBonus();

			if (actor.isPlacedOnMap() && ::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1, true).len() > 0)  //engaged
			{
				_properties.MeleeDefense += bonus * 0.01 * this.getContainer().getActor().getBaseProperties().getMeleeDefense();				
				bonus = bonus * 2;						
				crbonus *= 0;				
			}

			_properties.MeleeSkillMult *= 1 + crbonus * 0.01;
			_properties.MeleeDamageMult *= 1 + bonus * 0.01;
		}
	};
});	