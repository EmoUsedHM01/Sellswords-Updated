::Mod_Sellswords.doArrowChecks <- function ( _skill, _targetEntity, _actor )
{
	local weapon = _actor.getMainhandItem();

	switch (true)
	{
		case weapon == null:
		case !_skill.isAttack:
		case !_actor.isAlive():
		case _actor.isDying():
		case !_targetEntity.isAlive():
		case _targetEntity.isDying():
		case weapon.isWeaponType(this.Const.Items.WeaponType.Bow):
		case weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow):
			return true;
	}
	return false;
};