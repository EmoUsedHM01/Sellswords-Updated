::mods_hookExactClass("skills/effects/wms_mastery_effect", function(o) {
	o.onAfterUpdate = function(_properties)
	{
		if (_properties.IsSpecializedInPolearms)
		{
			local weapon = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

			if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.TwoHanded) && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon))
			{
				local skills = this.getContainer().getAllSkillsOfType(this.Const.SkillType.Active);
				foreach (skill in skills)
				{
					 if (skill.m.IsWeaponSkill && skill.m.MaxRange == 2 && skill.m.ActionPointCost >= 5)
					 {
						skill.m.ActionPointCost = this.m.HasPolearmMastery ? 5 : 6;
						if (this.getContainer().hasSkill("perk.crGrandslam"))
						{
							skill.m.ActionPointCost = this.m.HasPolearmMastery ? 7 : 8;
						}						 
					 }
				}
			}
		}
	}
})