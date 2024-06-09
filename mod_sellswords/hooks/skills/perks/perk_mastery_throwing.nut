::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_mastery_throwing", function ( q ) {
	q.onAnySkillUsed = @( __original ) function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || !_skill.isRanged()) return;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Throwing)) return;

		local actor = this.getContainer().getActor();
		local distance = _targetEntity.getTile().getDistanceTo(actor.getTile());
		if (distance <= 3)
		{
			_properties.DamageDirectAdd += 0.002 * actor.getCurrentProperties().getRangedSkill();
			_properties.DamageArmorMult += 0.0025 * actor.getCurrentProperties().getMeleeSkill();
		}
	}
});