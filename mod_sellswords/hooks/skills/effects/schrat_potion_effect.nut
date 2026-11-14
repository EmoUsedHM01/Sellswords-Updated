//"Schrat Symbiosis";
//"With the proper concoction, and implanting the heart of schrat into the body, the test subject can form a symbiosis with the heart, gaining the abilities and properties of a schrat.";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/schrat_potion_effect", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Name = ::Mod_Sellswords.Strings.schrat_potion_effect.Name;
	}

	q.getDescription = @(__original) function()
	{
		return ::Mod_Sellswords.Strings.schrat_potion_effect.Text;
	}

	q.getTooltip = @(__original) function()
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
				id = 11,
				type = "text",
				icon = "ui/icons/armor_body.png",
				text = ::Mod_Sellswords.Strings.schrat_potion_effect.Tooltip1
			}
		];

		if (this.getContainer().getActor().getFlags().has("schrat_g"))
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.schrat_potion_effect.Tooltip2
			});
		}

		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.schrat_potion_effect.Tooltip3
		});
		ret.push({
			id = 13,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = ::Mod_Sellswords.Strings.schrat_potion_effect.Tooltip4
		});

		return ret;
	}

	

	q.onBeforeDamageReceived <- function( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill == null)
			return;

		switch(_hitInfo.DamageType)
		{
		case this.Const.Damage.DamageType.Piercing:
			if (_skill == null) 
				_properties.DamageReceivedRegularMult *= 0.25;
			else if (_skill.isRanged())
			{
				local weapon = _skill.getItem();

				if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.Weapon))
				{
					if (weapon.isWeaponType(this.Const.Items.WeaponType.Bow) || weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow))
						_properties.DamageReceivedRegularMult *= 0.25;
					else if (weapon.isWeaponType(this.Const.Items.WeaponType.Throwing))
						_properties.DamageReceivedRegularMult *= 0.5;
					else
						_properties.DamageReceivedRegularMult *= 0.5;
				}
				else
					_properties.DamageReceivedRegularMult *= 0.2;
			}
			break;
		case this.Const.Damage.DamageType.Burning:
			_properties.DamageReceivedRegularMult *= 2;
			break;
		}
	}

	q.onDamageReceived <- function( _attacker, _damageHitpoints, _damageArmor )
	{
		if (!this.getContainer().getActor().getFlags().has("schrat_g"))
			return;

		local actor = this.getContainer().getActor().get();

		if (_damageHitpoints >= actor.getHitpointsMax() * 0.15)
		{
			local candidates = [];
			local myTile = actor.getTile();

			for( local i = 0; i < 6; i = i )
			{
				if (!myTile.hasNextTile(i))
				{
				}
				else
				{
					local nextTile = myTile.getNextTile(i);

					if (nextTile.IsEmpty && this.Math.abs(myTile.Level - nextTile.Level) <= 1)
						candidates.push(nextTile);
				}

				i = ++i;
			}

			if (candidates.len() != 0)
			{
				local spawnTile = candidates[this.Math.rand(0, candidates.len() - 1)];
				local sapling = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/schrat_small", spawnTile.Coords);
				sapling.setFaction(actor.getFaction() == this.Const.Faction.Player ? this.Const.Faction.PlayerAnimals : actor.getFaction());
				sapling.riseFromGround();
			}
		}
	}

});