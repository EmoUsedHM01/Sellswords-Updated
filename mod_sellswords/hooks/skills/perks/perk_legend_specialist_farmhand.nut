::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_farmhand", function ( q ) {

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
			if (item.getID() == "weapon.pitchfork" || item.getID() == "weapon.legend_wooden_pitchfork"  || item.getID() == "weapon.legend_hoe"  || item.getID() == "weapon.legend_scythe"  || item.getID() == "weapon.wooden_flail")
			{
				_properties.MeleeSkill += 12;
				_properties.DamageArmorMult += 0.25;
			}
			else if (this.Const.Items.WeaponType.Polearm)
			{
				_properties.MeleeSkill += 12 * dc;
				_properties.DamageArmorMult += 0.25 * dc;
			}
		}
	}

});