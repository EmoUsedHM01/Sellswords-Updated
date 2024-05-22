::mods_hookExactClass("skills/actives/legend_eat_rations_skill", function(o) {
	::Mod_Sellswords.HookHelper.hookNewEatFoodSystem(o, false);

	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.Icon = "ui/items/supplies/legend_fresh_fruit.png";
		this.m.IconDisabled = "ui/items/supplies/legend_fresh_fruit.png";
	}

	o.getTooltip = function()
	{
		local amount = this.m.Amount;
		local rations;

		if (this.Tactical.isActive())
		{
			rations = this.getContainer().getActor().getSkills().getSkillByID("effects.legend_rations_effect");

			if (rations != null)
			{
				amount = amount;
			}
		}

		local rate = this.Math.max(1, this.Math.ceil(amount / 8));		

		if (rations != null)
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
				text = "On self, will restore [color=" + this.Const.UI.Color.PositiveValue + "]" + rate + "[/color] Health per turn for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "On self, will recovers fatigue by [color=" + this.Const.UI.Color.PositiveValue + "]" + rate + "[/color] per turn for ten turns"
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
				icon = "ui/icons/initiative.png",
				text = "On self, will increase [color=" + this.Const.UI.Color.PositiveValue + "]" + rate + "[/color] Initiative for ten turns"
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

			local skill = this.new("scripts/skills/effects/legend_rations_effect");
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

		local rationsEffect;

		if (!_user.getSkills().hasSkill("effects.legend_stuffed_effect"))
		{
			if (!_user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " eats food and become stuffed");
			}

			foreach (effect in this.m.ValidEffects)
			{
				if (_user.getSkills().getSkillByID(effect))
				{
					rationsEffect = _user.getSkills().getSkillByID(effect);
				}
			}
			local amt = rationsEffect.getAmount();
			rationsEffect.setAmount(0.4 * amt);
			rationsEffect = this.new("scripts/skills/effects/legend_rations_effect");
			rationsEffect.setAmount(0.4 * amt + 0.8 * this.m.Amount);
			_user.getSkills().add(rationsEffect);				
			rationsEffect.resetTurns();	

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
					rationsEffect = _user.getSkills().getSkillByID(effect);
				}
			}
			local amt = rationsEffect.getAmount();
			rationsEffect.setAmount(0.4 * amt);
			rationsEffect = this.new("scripts/skills/effects/legend_rations_effect");
			rationsEffect.setAmount(0.4 * amt + 0.8 * this.m.Amount);
			_user.getSkills().add(rationsEffect);				
			rationsEffect.resetTurns();

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
					rationsEffect = _user.getSkills().getSkillByID(effect);
				}
			}
			local amt = rationsEffect.getAmount();
			rationsEffect.setAmount(0.4 * amt);
			rationsEffect = this.new("scripts/skills/effects/legend_rations_effect");
			rationsEffect.setAmount(0.4 * amt + 0.8 * this.m.Amount);
			_user.getSkills().add(rationsEffect);				
			rationsEffect.resetTurns();

			if (this.m.Item != null && !this.m.Item.isNull())
			{
				this.m.Item.removeSelf();
			}

			return true;
		}

		return false;
	}

})