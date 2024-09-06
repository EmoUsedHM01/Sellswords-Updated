::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/ghastly_touch", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "A touch of something that doesn\'t belong to the living world. Quickly drain away any piece of life or sanity your victim has.";
		this.m.KilledString = "Frightened to death";
		this.m.Icon = "skills/active_42.png";
		this.m.IconDisabled = "skills/active_42_sw.png";
	}
	
	q.getTooltip = @(__original) function()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Completely ignores armor"
		});
		return ret;
	}
	
	q.isHidden = @(__original) function()
	{
		if (!this.getContainer().hasSkill("effects.disarmed") && this.getContainer().getActor().getMainhandItem() != null && this.getContainer().getActor().getOffhandItem() != null)
		{
			return true;
		}

		return this.skill.isHidden();
	}
	
	q.onUpdate = @(__original) function( _properties )
	{
	}
	
	q.onAfterUpdate = @(__original) function( _properties )
	{
		if (this.getContainer().hasSkill("perk.ghost_ghastly_touch")) this.m.ActionPointCost -= 1;
	}
	
	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageRegularMin += 15;
			_properties.DamageRegularMax += 25;
			_properties.DamageArmorMult = 0.0;
			_properties.IsIgnoringArmorOnAttack = true;

			local mhand = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

			if (mhand != null)
			{
				_properties.DamageRegularMin -= mhand.m.RegularDamage;
				_properties.DamageRegularMax -= mhand.m.RegularDamageMax;
				
				_properties.DamageDirectAdd -= mhand.m.DirectDamageAdd;
			}

			if (this.canDoubleGrip())
			{
				_properties.DamageTotalMult /= 1.25;
			}
		}
	}
	
	q.canDoubleGrip <- function()
	{
		local main = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local off = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return main != null && off == null && main.isDoubleGrippable();
	}

});