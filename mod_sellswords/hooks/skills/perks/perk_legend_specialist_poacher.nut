::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_poacher", function ( q ) {

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
			if (item.getID() == "weapon.short_bow" || item.getID() == "weapon.wonky_bow" || item.getID() == "weapon.goblin_bow" || item.getID() == "weapon.goblin_heavy_bow" || item.getID() == "weapon.composite_bow")
			{
				_properties.RangedSkill += 12;
				_properties.DamageDirectMult += 0.25;
			}
			else if (item.isWeaponType(this.Const.Items.WeaponType.Bow))
			{
				_properties.RangedSkill += 12 * dc;
				_properties.DamageDirectMult += 0.25 * dc;
			}
		}
	}
});
