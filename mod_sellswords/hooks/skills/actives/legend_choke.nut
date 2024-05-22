::mods_hookExactClass("skills/actives/legend_choke", function ( o )
{
	o.getHitChance = function ( _targetEntity )
	{
		if (_targetEntity == null)
		{
			return 0;
		}

		local mod = 0;

		if (_targetEntity.getSkills().hasSkill("effects.legend_dazed"))
		{
			mod = mod + 10;
		}

		if (_targetEntity.getSkills().hasSkill("effects.legend_parried"))
		{
			mod = mod + 10;
		}

		if (_targetEntity.getSkills().hasSkill("effects.legend_grappled"))
		{
			mod = mod + 20;
		}

		if (_targetEntity.getSkills().hasSkill("effects.stunned"))
		{
			mod = mod + 20;
		}

		if (_targetEntity.getSkills().hasSkill("effects.sleeping"))
		{
			mod = mod + 20;
		}

		if (_targetEntity.getSkills().hasSkill("effects.net"))
		{
			mod = mod + 25;
		}

		if (_targetEntity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			mod = mod + 50;
		}

		if (_targetEntity != null && this.getContainer().getActor().isPlayerControlled())
		{
			local targetArmor = _targetEntity.getArmor(this.Const.BodyPart.Body);

			if (targetArmor > 125)
			{
				mod = mod - this.Math.min(35, (targetArmor - 125) / 5);
			}
		}

		local chance = (1.0 - _targetEntity.getFatiguePct()) * 50;
		return mod - this.Math.round(chance);
	};
	o.onGetHitFactors <- function ( _skill, _targetTile, _tooltip )
	{
		local targetEntity = _targetTile.getEntity();
		local targetArmor = targetEntity.getArmor(this.Const.BodyPart.Body);
		local modarmor;			
		if (targetArmor > 125)
		{
			modarmor = this.Math.min(35, (targetArmor - 125) / 5);
			_tooltip.push({
				icon = "ui/tooltips/negative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + modarmor + "%[/color] Firm armor"
			});				
		}	
		local modvigor = this.Math.floor((1.0 - targetEntity.getFatiguePct()) * 50);			
		_tooltip.push({
			icon = "ui/tooltips/negative.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + modvigor + "%[/color] Fresh and energetic"
		});	
		local mod = 0;
		if (targetEntity.getSkills().hasSkill("effects.legend_dazed"))
		{
			mod = mod + 10;
		}
		if (targetEntity.getSkills().hasSkill("effects.legend_parried"))
		{
			mod = mod + 10;
		}
		if (targetEntity.getSkills().hasSkill("effects.legend_grappled"))
		{
			mod = mod + 20;
		}
		if (targetEntity.getSkills().hasSkill("effects.stunned"))
		{
			mod = mod + 20;
		}
		if (targetEntity.getSkills().hasSkill("effects.sleeping"))
		{
			mod = mod + 20;
		}
		if (targetEntity.getSkills().hasSkill("effects.net"))
		{
			mod = mod + 25;
		}
		if (targetEntity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			mod = mod + 50;
		}	
		if (mod > 0)
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + mod + "%[/color] Negative status"
			});	
		}
	}
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		local actor = this.getContainer().getActor();

		if (actor.getOffhandItem() != null)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Damage halved due to holding something in your off hand"
			});
		}

		if (actor.getMainhandItem() != null)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "This skill is not useable due to holding something in your main hand"
			});
		}

		if (this.m.Backgrounds.find(actor.getBackground()) != null)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+25%[/color] Damage (from background)"
			});
		}

		return ret;
	}		
	o.isUsable = function ()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return (mainhand == null || this.getContainer().hasSkill("effects.disarmed")) && this.skill.isUsable();
	}		
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill != this)
		{
			return;
		}

		local chance = this.getHitChance(_targetEntity);
		local actor = this.getContainer().getActor();
		//local average = this.Math.max(50, actor.getInitiative() + actor.getHitpoints() - 25) / 5;
		local average = actor.getInitiative() / 4 + actor.getHitpoints() / 5;			

		if (actor.getOffhandItem() != null)
		{
			average = average * 0.5;
		}
		
		if (actor.getMainhandItem() != null)
		{
			average = average * 0.2;
		}			

		_properties.DamageRegularMin += average - 10;
		_properties.DamageRegularMax += average + 10;
		_properties.IsIgnoringArmorOnAttack = true;
		_properties.MeleeSkill += chance;
		_properties.HitChanceMult[this.Const.BodyPart.Head] = 0.0;
		_properties.HitChanceMult[this.Const.BodyPart.Body] = 1.0;
	}		
});