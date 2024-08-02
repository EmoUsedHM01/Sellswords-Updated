::Mod_Sellswords.HooksMod.hook("scripts/skills/traits/huge_trait", function( q ) {

	if (!(::Is_PTR_Exist))
	{
		q.m.Skills <- [];
	}

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
			if (weapon.m.FatigueOnSkillUse > 0 && _properties.FatigueOnSkillUse == 0) 
				_properties.FatigueOnSkillUse -= ::Math.min(3, weapon.m.FatigueOnSkillUse) * _properties.FatigueEffectMult;
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