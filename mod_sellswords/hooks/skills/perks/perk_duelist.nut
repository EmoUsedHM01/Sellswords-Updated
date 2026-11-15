::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_duelist", function ( q ) {
	q.getBonus = @(__original) function( _actor = null )
	{
		local bonus = __original(_actor);
		local actor = _actor != null ? _actor : this.getContainer().getActor();
		local weapon = actor.getMainhandItem();
		if (::Legends.Perks.has(actor, ::Legends.Perk.SsuGrandslam))
		{	
			if (weapon == null)
			{
				bonus += 0.5;
				return bonus;
			}
			else if (weapon.isItemType(this.Const.Items.ItemType.RangedWeapon) && !weapon.isWeaponType(this.Const.Items.WeaponType.Throwing))
			{
				return bonus;
			}
			else if (weapon.isItemType(this.Const.Items.ItemType.OneHanded))
			{
				bonus += 0.1;
				return bonus;
			}
			bonus += 0.2;
		}
		return bonus;
	}
});
