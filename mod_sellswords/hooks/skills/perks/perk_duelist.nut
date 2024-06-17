::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_duelist", function ( q ) {

	q.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		local weapon = this.getContainer().getActor().getMainhandItem();

		switch (true)
		{
			case !this.getContainer().hasSkill("perk.crGrandslam"):
				return;
			case weapon == null:
				_properties.DamageDirectAdd += 0.5;
				return;
			case weapon.isItemType(this.Const.Items.ItemType.OneHanded):
				_properties.DamageDirectAdd -= 0.1;
				return;
			case weapon.isItemType(this.Const.Items.ItemType.RangedWeapon) && !weapon.isWeaponType(this.Const.Items.WeaponType.Throwing):
				return;
		}
		_properties.DamageDirectAdd += 0.2;
	}
});
