::mods_hookExactClass("skills/actives/legend_eat_pie_skill", function(o) {
	::Mod_Sellswords.HookHelper.hookNewEatFoodSystem(o, false);

	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.Icon = "ui/items/supplies/legend_fresh_game.png";
		this.m.IconDisabled = "ui/items/supplies/legend_fresh_game.png";
	}

	o.getTooltip = function()
	{
		local amount = this.m.Amount;
		local pie;

		if (this.Tactical.isActive())
		{
			pie = this.getContainer().getActor().getSkills().getSkillByID("effects.legend_pie_effect");

			if (pie != null)
			{
				amount = amount;
			}
		}

		local rate = this.Math.max(1, this.Math.ceil(amount / 8));
		local crate = this.Math.ceil(1.5 * rate);		

		if (pie != null)
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
				icon = "ui/icons/fatigue.png",
				text = "On self, will recovers fatigue by [color=" + this.Const.UI.Color.PositiveValue + "]" + crate + "[/color] per turn for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "On self, will increase [color=" + this.Const.UI.Color.PositiveValue + "]" + rate + "[/color] Melee Skill for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "On self, will increase [color=" + this.Const.UI.Color.PositiveValue + "]" + rate + "[/color] Ranged Skill for ten turns"
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

			local skill = this.new("scripts/skills/effects/legend_pie_effect");
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

		local pieEffect;

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
					pieEffect = _user.getSkills().getSkillByID(effect);
				}
			}
			local amt = pieEffect.getAmount();
			pieEffect.setAmount(0.4 * amt);
			pieEffect = this.new("scripts/skills/effects/legend_pie_effect");
			pieEffect.setAmount(0.4 * amt + 0.8 * this.m.Amount);
			_user.getSkills().add(pieEffect);				
			pieEffect.resetTurns();

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
					pieEffect = _user.getSkills().getSkillByID(effect);
				}
			}
			local amt = pieEffect.getAmount();
			pieEffect.setAmount(0.4 * amt);
			pieEffect = this.new("scripts/skills/effects/legend_pie_effect");
			pieEffect.setAmount(0.4 * amt + 0.8 * this.m.Amount);
			_user.getSkills().add(pieEffect);				
			pieEffect.resetTurns();

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
					pieEffect = _user.getSkills().getSkillByID(effect);
				}
			}
			local amt = pieEffect.getAmount();
			pieEffect.setAmount(0.4 * amt);
			pieEffect = this.new("scripts/skills/effects/legend_pie_effect");
			pieEffect.setAmount(0.4 * amt + 0.8 * this.m.Amount);
			_user.getSkills().add(pieEffect);				
			pieEffect.resetTurns();

			if (this.m.Item != null && !this.m.Item.isNull())
			{
				this.m.Item.removeSelf();
			}

			return true;
		}

		return false;
	}

})