::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_pickaxe_skill", function ( q ) {

	q.onUpdate = @( __original ) function ( _properties )
	{
		local dc = 0;
		local actor = this.getContainer().getActor();
		if (actor.isPlayerControlled())
		{
			dc = this.getContainer().getActor().getDaysWithCompany();
		}
	
		dc = this.Math.floor(dc / 7);
		dc = 0.01 * this.Math.min(5 * dc + 25, 100);
		local item = this.getContainer().getActor().getMainhandItem();
		if (item != null)
		{
			if (item.getID() == "weapon.pickaxe" || item.getID() == "weapon.heavy_mining_pick")
			{
				_properties.MeleeSkill += 12;
			}
			else if (item.isWeaponType(this.Const.Items.WeaponType.Hammer) && item.isItemType(this.Const.Items.ItemType.TwoHanded))
			{
				_properties.MeleeSkill += 12 * dc;
			}
		}
	}
});
