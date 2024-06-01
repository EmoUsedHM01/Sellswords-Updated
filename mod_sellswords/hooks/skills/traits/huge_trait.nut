::Mod_Sellswords.HooksMod.hook("scripts/skills/traits/huge_trait", function( q ) {

	q.m.Skills <- [];

	q.getTooltip = @(__original) function()
	{
		local tooltip = __original();
		tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Weapons with extra Fatigue build-up on skills have this penalty reduced by [color=" + ::Const.UI.Color.PositiveValue + "]-3[/color]"
		});

		return tooltip;
	}

	q.onAfterUpdate = @(__original) function( _properties )
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null)
		{
			local skills = weapon.getSkills();
			if (skills.len() == 0)
			{
				this.m.Skills.clear();
				return;
			}

			if (weapon.m.FatigueOnSkillUse > 0)
			{
				foreach (skill in skills)
				{
					if (this.m.Skills.find(skill.getID()) == null)
					{
						this.m.Skills.push(skill.getID());
						skill.m.FatigueCost -= ::Math.min(3, weapon.m.FatigueOnSkillUse);
					}
				}
			}
		}
	}

	q.onRemoved = @(__original) function()
	{
		local equippedItem = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
		if (equippedItem != null)
		{
			this.getContainer().getActor().getItems().unequip(equippedItem);
			this.getContainer().getActor().getItems().equip(equippedItem);
		}
	}

});