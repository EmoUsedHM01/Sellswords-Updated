::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_muscularity", function ( q ) {

	q.onAnySkillUsed = @(__original) function ( _skill, _targetEntity, _properties )
	{
		local item = _skill.getItem();

		if (item != null && item.isItemType(this.Const.Items.ItemType.Defensive) && !item.isItemType(this.Const.Items.ItemType.Weapon))
		{
			return;
		}

		if (!_skill.isRanged() || (item != null && item.isItemType(this.Const.Items.ItemType.Weapon) && item.isWeaponType(this.Const.Items.WeaponType.Throwing)))
		{
			local bonus = this.getBonusDamage(item, _skill.m.MaxRange, _skill.m.ActionPointCost);

			_properties.DamageRegularMin += bonus;
			_properties.DamageRegularMax += bonus;

		}
	}

	q.getBonusDamage <- function ( _item, _maxRange, _actionPointCost, _actor = null )
	{
		local actor = _actor != null ? _actor : this.getContainer().getActor();
		local hp = actor.getHitpoints();

		if (::Legends.Perks.has(actor, ::Legends.Perk.SsuGrandslam))
		{
			hp = hp * 3;
		}

		if (_maxRange > 1)
		{
			hp = hp * 0.6;
		}

		if (_actionPointCost <= 3 && _item != null && _item.isItemType(this.Const.Items.ItemType.Weapon) && _item.isWeaponType(this.Const.Items.WeaponType.Sword, true))
		{
			hp = hp * 0.8;
		}

		if (_actionPointCost <= 3 && _item != null && _item.isItemType(this.Const.Items.ItemType.Weapon) && _item.isWeaponType(this.Const.Items.WeaponType.Sword))
		{
			hp = hp * 0.8;

			if (_item.isWeaponType(this.Const.Items.WeaponType.Dagger))
			{
				hp = hp * 0.8;
			}
		}

		return _actionPointCost <= 5 ? this.Math.min(40, this.Math.floor(_actionPointCost * hp * 0.015)) : this.Math.min(60, this.Math.floor(_actionPointCost * hp * 0.02));
	}

	q.getDynamicTooltip = @(__original) function ( _actor = null )
	{
		return [
			{
				id = 3,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_legend_muscularity.Tooltip, this.getBonusDamage(null, 1, 4, _actor), this.getBonusDamage(null, 1, 6, _actor))
			}
		];
	}

	q.getActorHoverTooltip = @(__original) function ( _activeEntity, _stacks = 1 )
	{
		return ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_legend_muscularity.Hover, this.getBonusDamage(null, 1, 4), this.getBonusDamage(null, 1, 6));
	}

});
