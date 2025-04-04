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
			local bonus = getBonusDamage(item, _skill.m.MaxRange, _skill.m.ActionPointCost);

			_properties.DamageRegularMin += bonus;
			_properties.DamageRegularMax += bonus;

		}
	}

	function getBonusDamage( _item, _maxRange, _actionPointCost )
	{
		local hp = this.getContainer().getActor().getHitpoints();

		if (this.getContainer().hasSkill("perk.crGrandslam"))
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
			if (!this.getContainer().hasSkill("perk.ptr_two_for_one"))
			{
				hp = hp * 0.8;
			}

			if (this.getContainer().hasSkill("perk.ptr_two_for_one") && _actionPointCost <= 2)
			{
				hp = hp * 0.8;
			}

			if (_item.isWeaponType(this.Const.Items.WeaponType.Dagger))
			{
				hp = hp * 0.8;
			}
		}

		return _actionPointCost <= 5 ? this.Math.min(40, this.Math.floor(_actionPointCost * hp * 0.015)) : this.Math.min(60, this.Math.floor(_actionPointCost * hp * 0.02));
	}

	q.getUnactivatedPerkTooltipHints = @(__original) function()
	{
		local bro = this.getContainer().getActor();
		local mainhand = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (mainhand == null || (!mainhand.isItemType(this.Const.Items.ItemType.MeleeWeapon) && !mainhand.isItemType(this.Const.Items.ItemType.TwoHanded) && !mainhand.isItemType(this.Const.Items.ItemType.Throwing)))
		{
			return [];
		}

		local text = "Bonus damage based on current Hitpoints and equipped Weapon:";
		if (mainhand.isWeaponType(this.Const.Items.WeaponType.Dagger)) {
			if (bro.getSkills().hasPerk(::Legends.Perk.SpecDagger))
			{
				text += "\n• [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getBonusDamage(mainhand, mainhand.getRangeMax(), 3) + "[/color] per AP for 3 AP or less"
			} else
			{
				text += "\n• [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getBonusDamage(mainhand, mainhand.getRangeMax(), 4) + "[/color] per AP for 4 AP or less"
			}
		} else {
			text += "\n• [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getBonusDamage(mainhand, mainhand.getRangeMax(), 5) + "[/color] per AP for 5 AP or less"
			text += "\n• [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getBonusDamage(mainhand, mainhand.getRangeMax(), 6) + "[/color] per AP for 6 AP or more"
		}

		return [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/damage_dealt.png",
				text = text
			}
		];
	}
});
