::mods_hookExactClass("skills/actives/legend_eat_pudding_skill", function(o) {
	::Mod_Sellswords.HookHelper.hookNewEatFoodSystem(o, false);

	o.getTooltip = function()
	{
		local amount = this.m.Amount;
		local pudding;

		if (this.Tactical.isActive())
		{
			pudding = this.getContainer().getActor().getSkills().getSkillByID("effects.legend_pudding_effect");

			if (pudding != null)
			{
				amount = amount;
			}
		}

		local rate = this.Math.max(1, this.Math.ceil(amount / 8));
		local crate = this.Math.ceil(1.5 * rate);		

		if (pudding != null)
		{
			rate = rate;
		}

		local title = this.getName() + " (" + this.m.Item.getName() + " : " + this.m.Amount + " units)";
		local ret = [
			{
				id = 1,
				type = "title",
				text = title
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "On self, will restore [color=" + this.Const.UI.Color.PositiveValue + "]" + crate + "[/color] Health per turn for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "On self, will increase [color=" + this.Const.UI.Color.PositiveValue + "]" + rate + "[/color] Resolve for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "On self, will increase [color=" + this.Const.UI.Color.PositiveValue + "]" + rate + "[/color] Melee Defenses for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "On self, will increase [color=" + this.Const.UI.Color.PositiveValue + "]" + rate + "[/color] Ranged Defenses for ten turns"
			}			
		];

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]AP cost is doubled because this character is engaged in melee[/color]"
			});
		}

		return ret;
	}

	o.onUse = function( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		if (target == null)
		{
			return false;
		}

		if (target.getID() != _user.getID())
		{
			if (!_user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " gives food to " + this.Const.UI.getColorizedEntityName(target));
			}

			this.spawnIcon("status_effect_93", _targetTile);
			this.Sound.play("sounds/combat/eat_01.wav", this.Const.Sound.Volume.Inventory);
			local item = this.m.Item.get();
			_user.getItems().removeFromBag(item);
			target.getItems().addToBag(item);
			return true;
		}

		if (!_user.getSkills().hasSkill("effects.legend_satiated_effect"))
		{
			if (!_user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " eats food and becomes satiated");
			}

			local skill = this.new("scripts/skills/effects/legend_pudding_effect");
			skill.setAmount(this.m.Amount);
			_user.getSkills().add(skill);
			local skill = this.new("scripts/skills/effects/legend_satiated_effect");
			_user.getSkills().add(skill);

			if (this.m.Item != null && !this.m.Item.isNull())
			{
				this.m.Item.removeSelf();
			}

			return true;
		}

		local puddingEffect;
		
		if (!_user.getSkills().hasSkill("effects.legend_stuffed_effect"))
		{
			if (!_user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " eats food and become stuffed");
			}

			_user.getSkills().add(this.new("scripts/skills/effects/legend_stuffed_effect"));
			
			foreach (effect in this.m.ValidEffects)
			{
				if (_user.getSkills().getSkillByID(effect))
				{
					puddingEffect = _user.getSkills().getSkillByID(effect);
				}
			}
			local amt = puddingEffect.getAmount();
			puddingEffect.setAmount(0.4 * amt);
			puddingEffect = this.new("scripts/skills/effects/legend_pudding_effect");
			puddingEffect.setAmount(0.4 * amt + 0.8 * this.m.Amount);
			_user.getSkills().add(puddingEffect);				
			puddingEffect.resetTurns();	
			
			if (this.m.Item != null && !this.m.Item.isNull())
			{
				this.m.Item.removeSelf();
			}

			return true;
		}

		if (!_user.getSkills().hasSkill("injury.sickness"))
		{
			if (!_user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " eats food and becomes sick");
			}

			_user.getSkills().add(this.new("scripts/skills/injury/sickness_injury"));
			foreach (effect in this.m.ValidEffects)
			{
				if (_user.getSkills().getSkillByID(effect))
				{
					puddingEffect = _user.getSkills().getSkillByID(effect);
				}
			}
			local amt = puddingEffect.getAmount();
			puddingEffect.setAmount(0.4 * amt);
			puddingEffect = this.new("scripts/skills/effects/legend_pudding_effect");
			puddingEffect.setAmount(0.4 * amt + 0.8 * this.m.Amount);
			_user.getSkills().add(puddingEffect);				
			puddingEffect.resetTurns();	

			if (this.m.Item != null && !this.m.Item.isNull())
			{
				this.m.Item.removeSelf();
			}

			return true;
		}

		if (!_user.getSkills().hasSkill("trait.fat"))
		{
			if (!_user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " eats food and becomes fat");
			}

			_user.getSkills().add(this.new("scripts/skills/traits/fat_trait"));
			foreach (effect in this.m.ValidEffects)
			{
				if (_user.getSkills().getSkillByID(effect))
				{
					puddingEffect = _user.getSkills().getSkillByID(effect);
				}
			}
			local amt = puddingEffect.getAmount();
			puddingEffect.setAmount(0.4 * amt);
			puddingEffect = this.new("scripts/skills/effects/legend_pudding_effect");
			puddingEffect.setAmount(0.4 * amt + 0.8 * this.m.Amount);
			_user.getSkills().add(puddingEffect);				
			puddingEffect.resetTurns();	

			if (this.m.Item != null && !this.m.Item.isNull())
			{
				this.m.Item.removeSelf();
			}

			return true;
		}

		return false;
	}

})