::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_drink_hexe_ichor_potion_skill", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.Description = "Give to an adjacent ally or drink yourself a dubious hexen brew, grants someone perfect focus, halving the action point costs of all skills for three turns. AP cost is doubled while engaged in melee, and anyone receiving the item needs to have a free bag slot.";
	}

	::Mod_Sellswords.HookHelper.hookDoubleAP_CostIfEngageMelee(q, false);

	q.getTooltip = @( __original ) function()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
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
				icon = "ui/icons/days_wounded.png",
				text = "grants perfect focus, halving the action point costs of all skills for three turns"
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

	q.onUse = @( __original ) function( _user, _targetTile )
	{
		local user = _targetTile.getEntity();

		if (_user.getID() == user.getID())
		{
			user.getSkills().add(this.new("scripts/skills/effects/legend_hexe_ichor_potion_effect"));

			if (!_user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " drinks Hexen Ichor");
			}

			if (this.m.Item != null && !this.m.Item.isNull())
			{
				this.m.Item.removeSelf();
			}

			this.Const.Tactical.Common.checkDrugEffect(user);
		}
		else
		{
			if (!_user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " gives Hexen Ichor Potion to " + this.Const.UI.getColorizedEntityName(user));
			}

			this.spawnIcon("status_effect_89", _targetTile);
			this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
			local item = this.m.Item.get();
			_user.getItems().removeFromBag(item);
			user.getItems().addToBag(item);
		}

		return true;
	}

})