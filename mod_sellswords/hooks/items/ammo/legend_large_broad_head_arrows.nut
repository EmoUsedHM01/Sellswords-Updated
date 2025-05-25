::Mod_Sellswords.HooksMod.hook("scripts/items/ammo/legend_large_broad_head_arrows", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Description = "A large quiver of arrows with broad tips, designed for tearing through flesh, but is easily stopped by armour.\nIs automatically refilled after each battle if you have enough ammunition.\nGrants [color=" + ::Const.UI.Color.PositiveValue + "]+30%[/color] Damage to Hitpoints but [color=" + ::Const.UI.Color.NegativeValue + "]-10%[/color] Armour Piercing and Armour Damage";
	}

	q.onAnySkillUsed = @(__original) function ( _skill, _targetEntity, _properties )
	{
		local item = _skill.getItem();
		if (_skill.isAttack() && item != null && item.isItemType(this.Const.Items.ItemType.Weapon) && item.isWeaponType(this.Const.Items.WeaponType.Bow))
		{
			_properties.DamageDirectMult *= 0.9;
			_properties.DamageArmorMult *= 0.9;
			_properties.RangedDamageMult *= 1.3;
		}
	}
});
