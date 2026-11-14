::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_choke_skill", function ( q ) {

	q.getHitChance = @( __original ) function ( _targetEntity )
	{
		if (_targetEntity == null)
		{
			return 0;
		}

		local mod = 0;

		if (_targetEntity.getSkills().hasSkill("effects.dazed"))
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
	q.onGetHitFactors = @( __original ) function ( _skill, _targetTile, _tooltip )
	{
		local targetEntity = _targetTile.getEntity();
		local targetArmor = targetEntity.getArmor(this.Const.BodyPart.Body);
		local modarmor;			
		if (targetArmor > 125)
		{
			modarmor = this.Math.min(35, (targetArmor - 125) / 5);
			_tooltip.push({
				icon = "ui/tooltips/negative.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.legend_choke_skill.Tooltip1, modarmor)
			});				
		}	
		local modvigor = this.Math.floor((1.0 - targetEntity.getFatiguePct()) * 50);			
		_tooltip.push({
			icon = "ui/tooltips/negative.png",
			text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.legend_choke_skill.Tooltip2, modvigor)
		});	
		local mod = 0;
		if (targetEntity.getSkills().hasSkill("effects.dazed"))
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
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.legend_choke_skill.Tooltip3, mod)
			});	
		}
	}
	q.getTooltip = @( __original ) function()
	{
		local ret = this.getDefaultTooltip();
		local actor = this.getContainer().getActor();

		if (actor.getOffhandItem() != null)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::Mod_Sellswords.Strings.legend_choke_skill.Tooltip4
			});
		}

		if (actor.getMainhandItem() != null)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::Mod_Sellswords.Strings.legend_choke_skill.Tooltip5
			});
		}

		return ret;
	}
			
	q.isUsable = @( __original ) function ()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return (mainhand == null || this.getContainer().hasSkill("effects.disarmed")) && this.skill.isUsable();
	}

	q.onAnySkillUsed = @( __original) function ( _skill, _targetEntity, _properties )
	{
		if (_skill != this)
		{
			return;
		}

		local chance = this.getHitChance(_targetEntity);
		local actor = this.getContainer().getActor();
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
