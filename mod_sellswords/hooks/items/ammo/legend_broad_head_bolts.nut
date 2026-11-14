::Mod_Sellswords.HooksMod.hook("scripts/items/ammo/legend_broad_head_bolts", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Description = ::Mod_Sellswords.Strings.legend_broad_head_bolts.Description;
	}

	q.onAnySkillUsed = @(__original) function ( _skill, _targetEntity, _properties )
	{
		local item = _skill.getItem();
		if (_skill.isAttack() && item != null && item.isItemType(this.Const.Items.ItemType.Weapon) && item.isWeaponType(this.Const.Items.WeaponType.Crossbow))
		{
			_properties.DamageDirectMult *= 0.9;
			_properties.DamageArmorMult *= 0.9;
			_properties.RangedDamageMult *= 1.3;
		}
	}
});
