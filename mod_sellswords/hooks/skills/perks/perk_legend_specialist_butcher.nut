::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_butcher", function ( q ) {

	q.onUpdate = @( __original ) function( _properties )
	{
		local dc = 0;
		local actor = this.getContainer().getActor().get();
		if (::MSU.isKindOf(actor, "player"))
		{
			dc = this.getContainer().getActor().getDaysWithCompany();
		}
	
		dc = this.Math.floor(dc/7);
		dc = 0.01 * this.Math.min(5 * dc + 25, 100);
		local item = this.getContainer().getActor().getMainhandItem();
		if (item != null)
		{
			if (item.getID() == "weapon.butchers_cleaver" || item.getID() == "weapon.legend_named_butchers_cleaver")
			{
				_properties.MeleeSkill += 12;
			}
			else if (item.isWeaponType(this.Const.Items.WeaponType.Cleaver))
			{
				_properties.MeleeSkill += (12 * dc);
			}
		}
	}
});
