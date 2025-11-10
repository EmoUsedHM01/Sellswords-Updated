::Mod_Sellswords.HooksMod.hook("scripts/items/ammo/legend_large_armor_piercing_arrows", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Description = "A large quiver of arrows thin piercing tips, designed for punching through thick armour.\nIs automatically refilled after each battle if you have enough ammunition.\nGrants [color=%positive%]+25%[/color] Armour Piercing but [color=%negative%]-5%[/color] Damage";
	}

	q.onAnySkillUsed = @(__original) function ( _skill, _targetEntity, _properties )
	{
		local item = _skill.getItem();
		if (_skill.isAttack() && item != null && item.isItemType(this.Const.Items.ItemType.Weapon) && item.isWeaponType(this.Const.Items.WeaponType.Bow))
		{
			_properties.DamageDirectMult += 0.25;
			_properties.RangedDamageMult *= 0.95;
		}
	}
});
